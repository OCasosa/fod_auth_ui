import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/fod_features.dart";
import "package:get_it/get_it.dart";

import "../../../../../core/constants/theme/app_separators.dart";
import "../../forms/register_biometrics_form.dart";

/// Bottomsheet to register for the biometric authentication
class BiometricsRegisterBottomsheet extends StatelessWidget {
  /// Bottomsheet to register for the biometric authentication
  const BiometricsRegisterBottomsheet({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Text(
              "biometricAuthActivate".tr(),
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSeparators.kVSeparatorSmall,
            RegisterBiometricsForm(
              onSubmit: (form) => _onFormSubmit(context, form),
            ),
          ],
        ),
      );

  Future _onFormSubmit(
    BuildContext context,
    RegisterBiometricsFormEntity form,
  ) async {
    final success = await BiometricsController.registerBiometrics(
      context: context,
      form: form,
    );

    if (!context.mounted) return;

    unawaited(context.router.maybePop(success));
  }
}

/// Shows a bottomsheet to toggle the biometric authentication
///
/// Returns true if the operation was successful
Future<bool> showBiometricsOverlay({
  required BuildContext context,
  bool? toggle,
}) async {
  late bool action;
  if (toggle == null) {
    final biometricsEnabledResponse = GetBiometricEnrollment(
      repository: GetIt.I.get(),
    ).call(
      params: const NoParams(),
    );

    action = biometricsEnabledResponse.fold(
      (l) => false,
      (r) => r,
    );
  } else {
    action = toggle;
  }

  if (!action) {
    final confirmation = await showWarningDialog(
      context: context,
      options: const ConfirmationDialogOptions(
        barrierDismissible: true,
        showCancel: true,
      ),
      texts: ConfirmationDialogTexts(
        title: "biometricDeregisterTitle".tr(),
        message: "biometricDeregisterMessage".tr(),
      ),
    );

    if (confirmation != DialogResult.ok || !context.mounted) return false;

    return BiometricsController.disableBiometrics(
      context: context,
    );
  } else {
    return await showModalBottomSheet<bool>(
          context: context,
          useRootNavigator: true,
          builder: (modalCtx) => const BiometricsRegisterBottomsheet(),
        ) ??
        false;
  }
}
