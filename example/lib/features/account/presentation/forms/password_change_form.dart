part of "../libraries/password_change_library.dart";

/// Form to change the current user account password.
class PasswordChangeForm extends StatefulWidget {
  /// Form to change the current user account password.
  const PasswordChangeForm({
    required this.onFormSubmit,
    required this.username,
    super.key,
  });

  /// Callback when the form is submitted and validated.
  final ValueChanged<PasswordChangeFormEntity> onFormSubmit;

  /// Name of the user.
  final String username;

  @override
  State<PasswordChangeForm> createState() => _PasswordChangeFormState();
}

class _PasswordChangeFormState extends State<PasswordChangeForm> {
  late GlobalKey<FormBuilderState> _formKey;
  late PasswordChangeFormEntity _formEntity;

  late FocusNode _newPasswordFocusNode;
  late FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>(debugLabel: "PasswordChangeForm");

    _formEntity = PasswordChangeFormEntity(
      username: widget.username,
      formKey: _formKey,
    );

    _newPasswordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _formEntity.formKey,
        child: Column(
          children: [
            FormBuilderPasswordField(
              name: _formEntity.oldPassword.field,
              label: "passwordCurrent".tr().toCapitalized(),
              autoFocus: true,
              onSubmitted: (_) => _newPasswordFocusNode.requestFocus(),
            ),
            AppSeparators.kVSeparatorLarge,
            NewPasswordSmallInput(
              name: _formEntity.newPasswordInput.field,
              onSubmit: () => _confirmPasswordFocusNode.requestFocus(),
            ),
            AppSeparators.kVSeparatorLarge,
            FormBuilderPasswordField(
              focusNode: _confirmPasswordFocusNode,
              name: _formEntity.confirmNewPassword.field,
              label: "passwordConfirm".tr().toCapitalized(),
              onSubmitted: (_) => _onFormSubmitted(),
            ),
            AppSeparators.kVSeparatorExtraLarge,
            ElevatedButton(
              onPressed: _onFormSubmitted,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              child: Text("passwordUpdate".tr().toCapitalized()),
            ),
          ],
        ),
      );

  void _onFormSubmitted() {
    if (!_formEntity.saveAndValidate()) return;

    widget.onFormSubmit(_formEntity);
  }
}
