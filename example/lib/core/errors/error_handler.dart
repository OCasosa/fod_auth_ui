import "package:dio/dio.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fpdart/fpdart.dart";

/// The [ErrorHandler] class is responsible for handling the exceptions
class ErrorHandler {
  /// Handles the exceptions that can be thrown in the application
  /// during an API call.
  ///
  /// It receives a [function] that is the API call to be executed.
  /// Returns an [Either] with the [Failure] or the [T] value.
  static Future<Either<Failure, T>> handleApiCall<T>(
    Future<T> Function() function,
  ) async {
    try {
      return Right(await function());
    } on HttpCallException catch (exception) {
      return Left(HttpCallFailure.fromException(exception));
    } on DioException catch (exception) {
      return Left(
        HttpCallFailure.fromException(
          exception.error! as HttpCallException,
        ),
      );
    } on EnvironmentException catch (e) {
      return Left(
        AppFailure.environment(
          exception: e,
        ),
      );
    } catch (e) {
      return Left(
        AppFailure.unexpected(e.toString()),
      );
    }
  }

  /// Handles the exceptions that can be thrown in the application
  /// during a cache call.
  ///
  /// It receives a [function] that is the cache call to be executed.
  /// Returns an [Either] with the [Failure] or the [T] value.
  static Either<Failure, T> handleCacheCall<T>(
    T Function() function,
  ) {
    try {
      return Right(function());
    } on CacheException catch (exception) {
      return Left(AppFailure.cacheException(exception));
    } catch (e) {
      return Left(
        AppFailure.unexpected(e.toString()),
      );
    }
  }

  /// Handles the exceptions that can be thrown in the application
  /// during a secure cache call.
  ///
  /// It receives a [function] that is the secure cache call to be executed.
  /// Returns an [Either] with the [Failure] or the [T] value.
  static Future<Either<Failure, T>> handleCacheCallAsync<T>(
    Future<T> Function() function,
  ) async {
    try {
      return Right(await function());
    } on CacheException catch (exception) {
      return Left(AppFailure.cacheException(exception));
    } catch (e) {
      return Left(
        AppFailure.unexpected(e.toString()),
      );
    }
  }
}
