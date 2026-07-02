import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";

import "../../../../../core/constants/theme/app_values.dart";
import "form_builder_password_field.dart";

/// An input containing the validations toggles for a new password that is
/// going to be assign to a user's account.
///
/// This is a condensed input in replace for the [NewPasswordInput] for the
/// password recovery form.
class NewPasswordSmallInput extends StatefulWidget {
  /// An input containing the validations toggles for a new password that is
  /// going to be assign to a user's account.
  const NewPasswordSmallInput({
    required this.name,
    this.autoFocus = false,
    this.onSubmit,
    super.key,
  });

  /// The name of the field
  final String name;

  /// True if the input should be autofocused
  final bool autoFocus;

  /// VoidCallback on submit
  final VoidCallback? onSubmit;

  @override
  State<NewPasswordSmallInput> createState() => _NewPasswordSmallInputState();
}

class _NewPasswordSmallInputState extends State<NewPasswordSmallInput> {
  List<bool> psswdLocks = [false, false, false, false];

  bool get isPasswordValid => psswdLocks.every((element) => element);

  int get _getMissingValidationsCount =>
      psswdLocks.where((element) => !element).length;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: FormBuilderPasswordField(
              name: widget.name,
              label: "passwordNew".tr().toCapitalized(),
              autoFocus: widget.autoFocus,
              onChanged: _checkLocks,
              onSubmitted: (_) => widget.onSubmit?.call(),
            ),
          ),
          const SizedBox(width: 20),
          Tooltip(
            triggerMode: TooltipTriggerMode.tap,
            showDuration: const Duration(seconds: 6),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: AppValues.kRoundedMedium,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withAlpha(100),
                  blurRadius: 5,
                ),
              ],
            ),
            richMessage: WidgetSpan(
              child: _NewPasswordRules(
                isLengthValid: psswdLocks.first,
                isSpecialCharValid: psswdLocks[1],
                isNumberValid: psswdLocks[2],
                isUppercaseValid: psswdLocks[3],
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isPasswordValid
                      ? Colors.green.shade700
                      : Colors.red.shade700,
                  width: 3,
                ),
              ),
              child: _getMissingValidationsCount == 0
                  ? Icon(
                      Icons.check,
                      size: 15,
                      color: Colors.green.shade700,
                    )
                  : Text(
                      _getMissingValidationsCount.toString(),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.red.shade700,
                      ),
                    ),
            ),
          ),
        ],
      );

  void _checkLocks(String? currentValue) {
    if (currentValue == null) {
      setState(() {
        psswdLocks = [false, false, false, false];
      });

      return;
    }

    setState(() {
      psswdLocks[0] = currentValue.length >= 6;
      psswdLocks[1] = currentValue.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
      psswdLocks[2] = currentValue.contains(RegExp("[0-9]"));
      psswdLocks[3] = currentValue.contains(RegExp("[A-Z]"));
    });
  }
}

class _NewPasswordRules extends StatelessWidget {
  const _NewPasswordRules({
    required this.isLengthValid,
    required this.isSpecialCharValid,
    required this.isNumberValid,
    required this.isUppercaseValid,
  });

  /// True if the password is greater or equals than 6 characters
  final bool isLengthValid;

  /// True if the password contains at least one special character
  final bool isSpecialCharValid;

  /// True if the password contains at least one number
  final bool isNumberValid;

  /// True if the password contains at least one uppercase letter
  final bool isUppercaseValid;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _NewPasswordRule(
            isValid: isLengthValid,
            text: "passwordRuleLength".tr(),
          ),
          _NewPasswordRule(
            isValid: isSpecialCharValid,
            text: "passwordRuleSpecialChar".tr(),
          ),
          _NewPasswordRule(
            isValid: isNumberValid,
            text: "passwordRuleNumber".tr(),
          ),
          _NewPasswordRule(
            isValid: isUppercaseValid,
            text: "passwordRuleUppercase".tr(),
          ),
        ],
      );
}

class _NewPasswordRule extends StatelessWidget {
  const _NewPasswordRule({
    required this.isValid,
    required this.text,
  });

  final bool isValid;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            isValid ? Icons.check : Icons.close,
            size: 15,
            color: isValid ? Colors.green.shade700 : Colors.red.shade700,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: context.textTheme.bodyMedium,
          ),
        ],
      );
}
