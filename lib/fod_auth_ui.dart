// ignore_for_file: unawaited_futures

import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/constants/classes/params.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/fod_features.dart";
import "package:get_it/get_it.dart";

import "core/routes/fod_auth_ui_router.gr.dart";
import "features/branding/business/entities/branding_props_entity.dart";

/// Initial class for activating the fod auth ui flow
class FodAuthUi {
  /// Goes to the corresponding login page
  ///
  /// If no username save in cache, redirects to the username input page
  /// If user saved but no biometrics enrolled, goes to password input page
  /// If username and bioemtrics enrolled, goes to biometrics page
  static Future<void> goToAuth({
    required BuildContext context,
  }) async {
    final authStepResponse = await GetUserAuthenticationPage(
      repository: GetIt.I.get<IdentityRepository>(),
      biometricRepository: GetIt.I.get<BiometricRepository>(),
      sessionRepository: GetIt.I.get<SessionRepository>(),
    ).call(
      params: const NoParams(),
    );

    if (!context.mounted) return;

    late AuthStep authStep;

    authStepResponse.fold(
      (l) => authStep = AuthStep.inputUser,
      (r) => authStep = r,
    );

    switch (authStep) {
      case AuthStep.inputUser:
        context.router.replace(const UsernameInputRoute());
      case AuthStep.inputPassword:
        context.router.replace(const PasswordInputRoute());

      case AuthStep.inputBiometric:
        context.router.replace(
          BiometricInputRoute(
            shouldShowBiometricDialog: true,
          ),
        );
    }
  }

  /// redirects to the main page of the application
  static Future<void> goToHome(BuildContext context) async {
    try {
      final homePage = GetIt.I.get<BrandingPropsEntity>().homePage;
      unawaited(
        context.router.replaceAll(
          [
            homePage,
          ],
        ),
      );
    } catch (e) {
      await showFailureDialog(
        context: context,
        failure: AppFailure.unexpected(
          "pageHomeLoadFailed".tr(),
        ),
      );
    }
  }
}
