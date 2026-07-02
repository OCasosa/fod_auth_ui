import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/extensions/string_extension.dart";
import "package:flutter_common_classes/extensions/theme_extension.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:fod_auth_flutter/fod_auth.dart";
import "package:smart_auth/smart_auth.dart";

/// A dialog displaying a 6 digit OTP input
class OTPDialogInput extends StatefulWidget {
  /// A dialog displaying a 6 digit OTP input
  const OTPDialogInput({super.key});

  @override
  State<OTPDialogInput> createState() => _OTPDialogInputState();
}

class _OTPDialogInputState extends State<OTPDialogInput> {
  late GlobalKey<FormBuilderState> _formKey;
  late OtpFormEntity _otpFormEntity;

  late SmsAutofillService _smsAutofillService;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>(debugLabel: "otp_dialog_input");
    _otpFormEntity = OtpFormEntity(
      formKey: _formKey,
    );
    _smsAutofillService = SmsAutofillService(
      SmartAuth.instance,
    );
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text("otpEnter".tr().toCapitalized()),
        content: FormBuilder(
          key: _otpFormEntity.formKey,
          child: SizedBox(
            height: 200,
            child: FormBuilderOTPField(
              name: _otpFormEntity.otpInput.field,
              smsRetriever: _smsAutofillService,
              onPinFilled: (p0) => _onFormSubmit(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "cancel".tr().toCapitalized(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
          ),
          TextButton(
            onPressed: _onFormSubmit,
            child: Text(
              "send".tr().toCapitalized(),
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.primary,
              ),
            ),
          ),
        ],
      );

  void _onFormSubmit() {
    if (!_otpFormEntity.saveAndValidate()) return;

    Navigator.of(context).pop(_otpFormEntity);
  }
}
