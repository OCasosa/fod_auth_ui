import "dart:async";

import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:fod_auth_flutter/core/services/sms_autofill_service.dart";
import "package:fod_auth_flutter/features/shared/business/forms/otp_form_entity.dart";
import "package:fod_auth_flutter/features/shared/presentation/widgets/fields/form_builder_otp_field.dart";
import "package:smart_auth/smart_auth.dart";

/// Form to verify the account email
class OTPForm extends StatefulWidget {
  /// Form to verify the account email
  const OTPForm({
    required this.onFormSubmit,
    required this.onOTPResend,
    this.listenForSmsCode = false,
    super.key,
  });

  /// Callback when the form is filled
  final Future Function(OtpFormEntity) onFormSubmit;

  /// Callback to resend the OTP
  final VoidCallback onOTPResend;

  /// True if the form should listen to the OTP code from the SMS
  final bool listenForSmsCode;

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  late GlobalKey<FormBuilderState> _formKey;
  late OtpFormEntity _otpFormEntity;
  late SmsAutofillService _smsAutofillService;
  late GlobalKey<FormBuilderOTPFieldState> _otpFieldState;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>(debugLabel: "otp_form");
    _otpFormEntity = OtpFormEntity(
      formKey: _formKey,
    );
    _otpFieldState =
        GlobalKey<FormBuilderOTPFieldState>(debugLabel: "otp_field");
    if (widget.listenForSmsCode) {
      _smsAutofillService = SmsAutofillService(
        SmartAuth.instance,
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.listenForSmsCode) _smsAutofillService.dispose();
    _formKey.currentState?.dispose();
    _otpFieldState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _otpFormEntity.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: FormBuilderOTPField(
                key: _otpFieldState,
                name: _otpFormEntity.otpInput.field,
                smsRetriever:
                    widget.listenForSmsCode ? _smsAutofillService : null,
                onPinFilled: (_) => _onFormSubmit(),
              ),
            ),
            const Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: _onFormSubmit,
              child: Text("otpEnter".tr().toCapitalized()),
            ),
            _ResendOTPButton(
              onPressed: widget.onOTPResend,
            ),
          ],
        ),
      );

  Future _onFormSubmit() async {
    if (!_otpFormEntity.saveAndValidate()) return;

    await widget.onFormSubmit(_otpFormEntity);

    _otpFieldState.currentState?.clearOtp();
  }
}

class _ResendOTPButton extends StatefulWidget {
  const _ResendOTPButton({
    required this.onPressed,
  });

  /// Callback to resend the OTP
  final VoidCallback onPressed;

  @override
  State<_ResendOTPButton> createState() => __ResendOTPButtonState();
}

class __ResendOTPButtonState extends State<_ResendOTPButton> {
  late Timer _timer;

  int _secondsBeforeActive = 15;
  bool _buttonActive = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: _buttonActive ? widget.onPressed : null,
        child: Text(
          "Volver a enviar el código${_buttonActive ? "" : " ($_secondsBeforeActive)"}",
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.secondary,
            decoration: TextDecoration.underline,
            decorationColor: context.colorScheme.secondary,
          ),
        ),
      );

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (_secondsBeforeActive <= 0) {
          setState(() {
            timer.cancel();
            _buttonActive = true;
          });
        } else {
          setState(() {
            _secondsBeforeActive--;
          });
        }
      },
    );
  }
}
