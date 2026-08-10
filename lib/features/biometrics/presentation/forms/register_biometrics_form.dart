import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/features/fod_onboarding.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:flutter_form_builder/flutter_form_builder.dart";
import "package:fod_auth_flutter/features/biometrics/business/forms/register_biometrics_form_entity.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../password/presentation/widgets/text_fields/form_builder_password_field.dart";
import "../../../shared/presentation/widgets/label_text.dart";

/// Form to activate the biometric authentication
class RegisterBiometricsForm extends StatefulWidget {
  /// Form to activate the biometric authentication
  const RegisterBiometricsForm({
    required this.onSubmit,
    this.expandButton = false,
    super.key,
  });

  /// If true the separation between the form and the button
  /// will be expanded
  final bool expandButton;

  /// Callback function that is executed when the form is submitted
  final Function(RegisterBiometricsFormEntity form) onSubmit;

  @override
  State<RegisterBiometricsForm> createState() => _RegisterBiometricsFormState();
}

class _RegisterBiometricsFormState extends State<RegisterBiometricsForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late RegisterBiometricsFormEntity _form;

  @override
  void initState() {
    _form = RegisterBiometricsFormEntity(
      formKey: _formKey,
    );
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _form.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelText(
              title: "passwordEnter".tr(),
              isRequired: true,
              child: FormBuilderPasswordField(
                name: _form.password.field,
                autoFocus: true,
              ),
            ),
            AppSeparators.kVSeparator,
            BlockQuote(
              blockType: CardType.warning,
              message: "biometricWarningText".tr(),
            ),
            widget.expandButton
                ? const Spacer()
                : AppSeparators.kVSeparatorLarge,
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _onFormSubmitted,
              child: Text(
                "activate".tr().toCapitalized(),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      );

  Future _onFormSubmitted() async {
    try {
      if (_form.saveAndValidate()) {
        widget.onSubmit(_form);
      }
    } catch (e) {
      await showErrorDialog(
        context: context,
        texts: ConfirmationDialogTexts(
          title: e.toString(),
        ),
      );
    }
  }
}
