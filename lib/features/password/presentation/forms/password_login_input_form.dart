part of "../libraries/password_input_library.dart";

/// Form where the user inputs their password to login to the app.
class _PasswordLoginInputForm extends StatefulWidget {
  const _PasswordLoginInputForm({
    required this.onFormSubmitted,
  });

  final ValueChanged<String> onFormSubmitted;

  @override
  State<_PasswordLoginInputForm> createState() =>
      _PasswordLoginInputFormState();
}

class _PasswordLoginInputFormState extends State<_PasswordLoginInputForm> {
  late final GlobalKey<FormBuilderState> _formKey;
  late final PasswordLoginFormEntity _formEntity;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>(
      debugLabel: "_PasswordLoginFormState",
    );
    _formEntity = PasswordLoginFormEntity(
      formKey: _formKey,
    );
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _formEntity.formKey,
        child: Column(
          children: [
            FormBuilderPasswordField(
              name: _formEntity.password.field,
              autoFocus: true,
              onSubmitted: (password) => _onFormSubmitted(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _onForgotPasswordPressed,
                child: Text("passwordForgot".tr().toCapitalized()),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                padding: const EdgeInsets.symmetric(
                  vertical: 17,
                  horizontal: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onPressed: _onFormSubmitted,
              child: Text(
                "signInSession".tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      );

  Future _onFormSubmitted() async {
    if (!_formEntity.saveAndValidate()) return;

    widget.onFormSubmitted(
      _formEntity.password.value!,
    );
  }

  Future _onForgotPasswordPressed() => context.router.push(
        PasswordRecoverRoute(
          title: "passwordForgot".tr().toCapitalized(),
          subtitle: "passwordChangeFillFormText".tr().toCapitalized(),
        ),
      );
}
