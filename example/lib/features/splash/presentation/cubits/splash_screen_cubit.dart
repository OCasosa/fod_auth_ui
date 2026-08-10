import "package:easy_localization/easy_localization.dart";
import "package:equatable/equatable.dart";
import "package:flutter_common_classes/flutter_common_classes.dart"
    hide DependencyInjection;
import "package:fod_auth_flutter/fod_auth.dart";
import "package:get_it/get_it.dart";

import "../../../../core/config/dependency_injection.dart";
import "../../../notification/notification.dart";

part "splash_screen_state.dart";

/// Cubit in charge of managing the splash screen state.
class SplashScreenCubit extends Cubit<SplashScreenState> {
  /// Constructor for the cubit.
  SplashScreenCubit() : super(const SplashScreenLoading()) {
    _startApp();
  }

  final Logger _logger = getLogger("SplashScreenCubit");

  bool _isAnimationFinished = false;
  bool _areServicesReady = false;
  bool _anErrorOccurred = false;
  bool _hasNewVersion = false;
  bool _isUserFirstTime = false;

  /// Page where the app must go after the splash screen
  AuthStep? authStep;

  /// Entry point of the application.
  Future<void> _startApp() async {
    await _injectDependencies();
    if (_anErrorOccurred) return;

    await _loadUserData();
    if (_anErrorOccurred) return;
    await _askPermissions();

    if (state is SplashScreenFailure) {
      return;
    }
    _markServicesReady();
  }

  /// Method to be called when the animation has finished.
  ///
  /// If the services are ready, it will emit a [SplashScreenSuccess] state.
  /// If the services are not ready, it will emit a
  /// [SplashScreenAnimationFinished] state.
  void markAnimationFinished() {
    if (_anErrorOccurred || _hasNewVersion) {
      return;
    }
    _isAnimationFinished = true;

    if (_areServicesReady) {
      safeEmit(
        SplashScreenSuccess(
          isUserFirstTime: _isUserFirstTime,
        ),
      );
    } else {
      safeEmit(const SplashScreenAnimationFinished());
    }
  }

  void _markServicesReady() {
    _areServicesReady = true;

    if (_isAnimationFinished) {
      safeEmit(
        SplashScreenSuccess(
          isUserFirstTime: _isUserFirstTime,
        ),
      );
    }
  }

  Future _injectDependencies() async {
    try {
      await DependencyInjection.injectServices();
      await DependencyInjection.injectPublicRepositories();
    } catch (e) {
      _anErrorOccurred = true;
      safeEmit(
        SplashScreenFailure(
          failure: AppFailure.unexpected(
            e.toString(),
          ),
        ),
      );
    }
  }

  Future _loadUserData() async {
    final authStepResponse = await GetUserAuthenticationPage(
      repository: GetIt.I.get<IdentityRepository>(),
      biometricRepository: GetIt.I.get<BiometricRepository>(),
      sessionRepository: GetIt.I.get<SessionRepository>(),
    ).call(
      params: const NoParams(),
    );

    authStepResponse.fold(
      (failure) {
        _anErrorOccurred = true;
        safeEmit(SplashScreenFailure(failure: failure));
      },
      (authStepValue) {
        authStep = authStepValue;
      },
    );
  }

  Future _askPermissions() async {
    final locationPermission = await GetLocationPermission(
      repository: GetIt.I.get<DeviceLocationRepository>(),
    ).call(
      params: const NoParams(),
    );

    locationPermission.fold(
      (failure) {
        _logger.e("Error: ${failure.message}");
        _anErrorOccurred = true;
        safeEmit(SplashScreenFailure(failure: failure));
      },
      (permission) {
        if (!permission) {
          _logger.e("Location permission denied");
          _anErrorOccurred = true;
          safeEmit(
            SplashScreenFailure(
              failure: AppFailure(
                title: "locationUnavailable".tr(),
                message: "locationPermissionDenied".tr(),
              ),
            ),
          );
        }
      },
    );

    await PostLocalPushNotificationPermission(
      repository: GetIt.I.get<PushNotificationRepository>(),
    ).call(
      params: const NoParams(),
    );
  }
}
