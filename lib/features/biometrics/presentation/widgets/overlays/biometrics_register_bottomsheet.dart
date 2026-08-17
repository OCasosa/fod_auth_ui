import "dart:async";
import "dart:developer";
import "dart:io";

import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/biometrics/business/use_cases/set_biometric_prompt_flag.dart";
import "package:fod_auth_flutter/features/fod_features.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:form_builder_z/models/input_entity.dart";
import "package:get_it/get_it.dart";

import "../../../../../core/constants/theme/app_separators.dart";
import "../../../../shared/presentation/widgets/block_quote.dart";
import "../../forms/register_biometrics_form.dart";

part "password_confirmation_section.dart";

/// Bottomsheet to register for the biometric authentication
class BiometricsRegisterBottomsheet extends StatelessWidget {
  /// Bottomsheet to register for the biometric authentication
  const BiometricsRegisterBottomsheet({
    super.key,
    this.password,
  });

  /// Password to store
  ///
  /// If null, the bottomsheet will ask the user it´s password
  final String? password;

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
            if (password == null) ...[
              RegisterBiometricsForm(
                onSubmit: (form) => _onFormSubmit(context, form),
              ),
            ] else ...[
              Expanded(
                child: _PasswordConfirmationSection(
                  onCancel: () => context.router.maybePop(false),
                  onConfirm: () => _onFormSubmit(
                    context,
                    RegisterBiometricsFormEntity(
                      password: InputEntity.dirty(
                        field: "password",
                        validators: const [],
                        value: password,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
      checkPasswordWithServer: password == null,
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
  bool retrievePasswordFromSession = false,
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

  String? password;

  if (retrievePasswordFromSession) {
    final passwordResponse = GetSessionUseCase(
      repository: GetIt.I.get(),
    ).call(
      params: const NoParams(),
    );

    password = passwordResponse.fold(
      (l) {
        log("Error: $l");

        return null;
      },
      (r) => r.password,
    );
  }

  log("Password: $password");

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
    unawaited(
      SetBiometricPromptFlag(
        repository: GetIt.I.get(),
      ).call(
        params: true,
      ),
    );

    return await showModalBottomSheet<bool>(
          context: context,
          useRootNavigator: true,
          builder: (modalCtx) => BiometricsRegisterBottomsheet(
            password: password,
          ),
        ) ??
        false;
  }
}
