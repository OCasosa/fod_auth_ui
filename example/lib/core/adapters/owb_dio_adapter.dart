import "dart:async";

import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:flutter/foundation.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_pretty_dio_logger/flutter_pretty_dio_logger.dart";
import "package:fod_auth_flutter/fod_auth.dart";
import "package:get_it/get_it.dart";

/// Adapter for the Dio client
///
/// This adapter is used to create a Dio client with the necessary
/// configurations for the application. It also includes the necessary
/// error handling for the application.
class OWBDioAdapter extends DioForNative {
  /// Adapter for the Dio client
  ///
  /// This adapter is used to create a Dio client with the necessary
  /// configurations for the application. It also includes the necessary
  /// error handling for the application.
  OWBDioAdapter({
    required this.internetInfo,
    required this.baseUrl,
    required this.accessKey,
    this.receiveTimeout,
    this.connectTimeout,
    this.sendTimeout,
  }) {
    _initializeAdapter();
  }

  /// Base url
  final String baseUrl;

  /// Access key
  final String accessKey;

  /// Information about the internet connection
  final NetworkInfo internetInfo;

  /// The timeout for the receive operation
  final Duration? receiveTimeout;

  /// The timeout for the connect operation
  final Duration? connectTimeout;

  /// The timeout for the send operation
  final Duration? sendTimeout;

  void _initializeAdapter() {
    options = BaseOptions(
      baseUrl: baseUrl,
      sendTimeout: sendTimeout,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      contentType: "application/json",
      responseType: ResponseType.json,
      headers: {
        "X-Access-Key": accessKey,
      },
    );

    interceptors
      ..add(
        PrettyDioLogger(
          requestHeader: true,
          queryParameters: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          showProcessingTime: false,
          showCUrl: false,
          canShowLog: kDebugMode,
        ),
      )
      ..add(
        InterceptorsWrapper(
          onRequest: onRequestMethod,
          onResponse: onResponseMethod,
          onError: onErrorMethod,
        ),
      );
  }

  /// Handles the request prior to being sent
  FutureOr<void> onRequestMethod(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final locationResponse = await GetDeviceLocation(
        repository: GetIt.I.get<DeviceLocationRepository>(),
      ).call(params: const NoParams());

      late DeviceLocationEntity location;
      Failure? failure;

      locationResponse.fold(
        (l) => failure = l,
        (r) => location = r,
      );

      if (failure != null) {
        handler.reject(
          DioException.badResponse(
            statusCode: 400,
            response: Response(
              statusCode: 400,
              requestOptions: options,
              data: {
                "detail": failure!.message,
              },
            ),
            requestOptions: options,
          ),
          true,
        );

        return;
      }

      final tokenResponse = GetSessionUseCase(
        repository: GetIt.I.get<SessionRepository>(),
      ).call(
        params: const NoParams(),
      );

      late SessionEntity sessionEntity;

      tokenResponse.fold(
        (l) => failure = l,
        (r) => sessionEntity = r,
      );

      if (failure != null) {
        handler.reject(
          DioException.badResponse(
            statusCode: 400,
            response: Response(
              statusCode: 400,
              requestOptions: options,
              data: {
                "detail": failure!.message,
              },
            ),
            requestOptions: options,
          ),
          true,
        );

        return;
      }

      options.headers.addAll({
        "FOD-Geolocation": location.position,
        "Authorization": "Bearer ${sessionEntity.token?.accessToken}",
      });

      handler.next(options);
    } catch (e) {
      handler.reject(
        DioException.badResponse(
          statusCode: 400,
          response: Response(
            statusCode: 400,
            requestOptions: options,
            data: {
              "detail": e.toString(),
            },
          ),
          requestOptions: options,
        ),
        true,
      );
    }
  }

  /// Handles the response prior to being returned
  FutureOr<void> onResponseMethod(
    Response response,
    ResponseInterceptorHandler handler,
  ) async =>
      handler.next(response);

  /// Handles the error prior to being thrown
  FutureOr<void> onErrorMethod(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      HttpCallException? errorObject;
      switch (error.type) {
        case DioExceptionType.connectionError:
          errorObject = await internetInfo.isConnected
              ? ConnectionErrorException.serverDown()
              : ConnectionErrorException.clientOffline();

        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          errorObject = await internetInfo.isConnected
              ? ConnectionErrorException.serverDown()
              : ConnectionErrorException.clientOffline();

        case DioExceptionType.badResponse:
          final statusCode = error.response!.statusCode!;

          if (statusCode.isBetween(300, 499)) {
            if (statusCode == 404) {
              errorObject = error.response?.data is String
                  ? ClientErrorException.notFound(
                      code: statusCode,
                    )
                  : ClientErrorException.notFound(
                      message: error.response?.data["detail"] as String?,
                      data: error.response?.data,
                      code: statusCode,
                    );
            } else if (statusCode.isBetween(401, 403)) {
              final data = error.response?.data;

              errorObject = data is String
                  ? ClientErrorException.unauthorized(
                      code: statusCode,
                      data: {
                        "message": data,
                      },
                    )
                  : ClientErrorException.unauthorized(
                      code: statusCode,
                      message: data["detail"] as String?,
                      data: data,
                    );
            } else if (statusCode == 422) {
              errorObject = ClientErrorException.badRequest(
                code: statusCode,
                message: (error.response!.data["errors"] as List).reduce(
                  (a, b) => "$a\n$b",
                ),
                data: error.response?.data,
              );
            } else {
              if (error.response?.data is String) {
                errorObject = ClientErrorException.badRequest(
                  code: statusCode,
                );
              } else {
                final errorMessage = error.response?.data["detail"] != null
                    ? (error.response!.data["detail"] as String).trim()
                    : null;

                errorObject = ClientErrorException.badRequest(
                  code: statusCode,
                  message: errorMessage,
                  data: error.response?.data,
                );
              }
            }
          } else if (statusCode.isBetween(500, 599)) {
            if (error.response?.data is String) {
              errorObject = ServerErrorException(
                title: "Error del servidor",
                message: "Estamos trabajando en ello lo más rápido posible",
              );
            } else {
              final String? generalMessage =
                  error.response?.data["title"] as String?;

              final String? innerMessage =
                  error.response?.data["detail"] as String?;

              errorObject = ServerErrorException(
                title: generalMessage ?? "Error del servidor",
                message: innerMessage ??
                    "Estamos trabajando en ello lo más rápido posible",
                data: error.response?.data,
              );
            }
          } else {
            errorObject = ClientErrorException.badRequest();
          }
        case DioExceptionType.cancel:
          errorObject = ClientErrorException.cancelRequest();
        case DioExceptionType.badCertificate:
          errorObject = ServerErrorException.badCertificate();
        case DioExceptionType.unknown:
          errorObject = await internetInfo.isConnected
              ? ConnectionErrorException.serverDown()
              : ConnectionErrorException.clientOffline();
      }

      final customError = error.copyWith(
        error: errorObject,
      );

      handler.reject(customError);

      return;
    } catch (e) {
      handler.reject(
        DioException(
          type: DioExceptionType.unknown,
          response: Response(
            statusCode: 500,
            requestOptions: error.requestOptions,
          ),
          requestOptions: error.requestOptions,
          error: ServerErrorException(
            title: "Error del adaptador",
            message: e.toString(),
          ),
        ),
      );
    }
  }
}
