part of "../libraries/username_input_library.dart";

class _UserLoginInputForm extends StatefulWidget {
  const _UserLoginInputForm({
    required this.onFormSubmited,
  });

  final ValueChanged<String> onFormSubmited;

  @override
  State<_UserLoginInputForm> createState() => _UserLoginInputFormState();
}

class _UserLoginInputFormState extends State<_UserLoginInputForm> {
  final _formKey =
      GlobalKey<FormBuilderState>(debugLabel: "_UserLoginFormState");

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FormBuilderTextField(
              name: "email",
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              onTapOutside: (event) => hideKeyboard(),
              decoration: InputDecoration(
                hintText: "email".tr().toCapitalized(),
                errorMaxLines: 2,
                prefixIcon: const Icon(
                  FontAwesomeIcons.envelope,
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
              onSubmitted: (_) => _onFormSubmitted(),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _onFormSubmitted,
              child: Text(
                "sign_in_button".tr(),
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      );

  /// Handles the form submission.
  Future _onFormSubmitted() async {
    if (_formKey.currentState == null) return;

    if (_formKey.currentState!.saveAndValidate(
      autoScrollWhenFocusOnInvalid: true,
    )) {
      widget.onFormSubmited(
        _formKey.currentState!.fields["email"]!.value as String,
      );
    }
  }
}
