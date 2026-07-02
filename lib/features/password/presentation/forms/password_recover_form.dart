import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:fod_auth_flutter/features/communication/business/enums/enums.dart";
import "package:fod_auth_flutter/features/password/password.dart";
import "package:fod_auth_flutter/features/shared/shared.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../communication/widgets/bottomsheets/communication_channel_bottom_sheet_form_field.dart";
import "../../../otp/presentation/widgets/overlays/otp_dialog_input.dart";
import "../widgets/text_fields/form_builder_password_field.dart";
import "../widgets/text_fields/new_password_small_input.dart";

/// Form to recover the current user account password.
class PasswordRecoverForm extends StatefulWidget {
  /// Form to recover the current user account password.
  const PasswordRecoverForm({
    required this.onFormSubmit,
    super.key,
  });

  /// Callback when the form is completed
  final void Function(
    RecoverPasswordFormEntity recoverFormEntity,
    OtpFormEntity otpFormEntity,
  ) onFormSubmit;

  @override
  State<PasswordRecoverForm> createState() => _PasswordRecoverFormState();
}

class _PasswordRecoverFormState extends State<PasswordRecoverForm> {
  late GlobalKey<FormBuilderState> _formKey;
  late RecoverPasswordFormEntity _formEntity;

  late FocusNode _confirmPasswordFocusNode;
  late GlobalKey<FormBuilderDropdownSearchState<CommunicationChannelsEnum>>
      _otpProviderKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>(debugLabel: "PasswordRecoverForm");
    _formEntity = RecoverPasswordFormEntity(
      formKey: _formKey,
    );

    _confirmPasswordFocusNode = FocusNode();
    _otpProviderKey =
        GlobalKey<FormBuilderDropdownSearchState<CommunicationChannelsEnum>>();

    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();

    _confirmPasswordFocusNode.dispose();
    _otpProviderKey.currentState?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _formEntity.formKey,
        child: Column(
          children: [
            NewPasswordSmallInput(
              name: _formEntity.newPasswordInput.field,
              autoFocus: true,
              onSubmit: () => _confirmPasswordFocusNode.requestFocus(),
            ),
            AppSeparators.kVSeparatorLarge,
            FormBuilderPasswordField(
              focusNode: _confirmPasswordFocusNode,
              name: _formEntity.confirmPasswordInput.field,
              label: "passwordConfirm".tr().toCapitalized(),
              autoFocus: true,
              onSubmitted: (_) =>
                  _otpProviderKey.currentState?.openDropDownSearch(),
            ),
            AppSeparators.kVSeparatorLarge,
            CommunicationChannelBottomSheetFormField(
              bottomSheetKey: _otpProviderKey,
              name: _formEntity.otpProviderInput.field,
              onChanged: _onOtpSelect,
            ),
            AppSeparators.kVSeparatorExtraLarge,
            ElevatedButton(
              onPressed: _onFormCompleted,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text("otpSend".tr().toCapitalized()),
            ),
          ],
        ),
      );

  Future _onFormCompleted() async {
    if (!_formEntity.saveAndValidate()) return;

    final otpSent = await PasswordController.requestPasswordRecoveryOTP(
      context: context,
      provider: _formEntity.otpProviderInput.value!,
    );

    if (!otpSent || !mounted) return;

    final otpFormEntity = await showDialog<OtpFormEntity>(
      context: context,
      builder: (context) => const OTPDialogInput(),
    );

    if (otpFormEntity == null || !mounted) return;

    widget.onFormSubmit(
      _formEntity,
      otpFormEntity,
    );
  }

  void _onOtpSelect(CommunicationChannelsEnum? value) {
    if (value == null) return;

    _onFormCompleted();
  }
}
