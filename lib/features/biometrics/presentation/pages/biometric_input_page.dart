part of "../libraries/biometric_input_library.dart";

/// Page where the user inputs their biometrics to login to the app.
///
/// This page is only accessible after the user has input their username.
@RoutePage()
class BiometricInputPage extends StatelessWidget {
  /// Page where the user inputs their biometrics to login to the app.
  ///
  /// This page is only accessible after the user has input their username.
  const BiometricInputPage({
    super.key,
    this.pageInfo,
    this.shouldShowBiometricDialog = false,
  });

  /// The information of the user to be authenticated.
  ///
  /// If this is null, then the information will be fetched from the server.
  final AuthPasswordPageInfoEntity? pageInfo;

  /// True if the biometric sensor should be automatically shown.
  final bool shouldShowBiometricDialog;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: pageInfo != null
            ? _SuccessContent(
                pageInfo: pageInfo!,
                shouldShowBiometricDialog: shouldShowBiometricDialog,
              )
            : BlocProvider(
                create: (context) => AuthInfoStateCubit(),
                child: Scaffold(
                  body: _BiometricInputContent(
                    shouldShowBiometricDialog: shouldShowBiometricDialog,
                  ),
                ),
              ),
      );
}

class _BiometricInputContent extends StatelessWidget {
  const _BiometricInputContent({
    this.shouldShowBiometricDialog = false,
  });

  final bool shouldShowBiometricDialog;

  @override
  Widget build(BuildContext context) =>
      CubitWidgetStateBuilder<AuthInfoStateCubit, AuthPasswordPageInfoEntity>(
        onSuccess: (info) => _SuccessContent(
          pageInfo: info,
          shouldShowBiometricDialog: shouldShowBiometricDialog,
        ),
        onFailure: (failure) => FailureView(
          failure,
          onRetry: () => context.read<AuthInfoStateCubit>().getInfo(),
        ),
      );
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent({
    required this.pageInfo,
    this.shouldShowBiometricDialog = false,
  });

  final AuthPasswordPageInfoEntity pageInfo;

  final bool shouldShowBiometricDialog;

  @override
  Widget build(BuildContext context) => _BiometricLoginContent(
        initials: pageInfo.maskedUsername,
        user: pageInfo.username,
        shouldShowBiometricDialog: shouldShowBiometricDialog,
        moveToPasswordInput: () => _moveToPasswordInput(context),
      );

  Future _moveToPasswordInput(BuildContext context) => context.router.replace(
        const PasswordInputRoute(),
      );
}

class _BiometricLoginContent extends StatefulWidget {
  const _BiometricLoginContent({
    required this.initials,
    required this.user,
    required this.moveToPasswordInput,
    this.shouldShowBiometricDialog = false,
  });

  /// True if the biometric dialog should be automatically shown.
  final bool shouldShowBiometricDialog;

  /// User initials
  final String initials;

  /// User name
  final String user;

  final VoidCallback moveToPasswordInput;

  @override
  State<_BiometricLoginContent> createState() => _BiometricLoginContentState();
}

class _BiometricLoginContentState extends State<_BiometricLoginContent> {
  @override
  void initState() {
    if (widget.shouldShowBiometricDialog) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _onFormSubmitted(context),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: context.colorScheme.secondaryContainer,
                      foregroundColor: context.colorScheme.onSecondaryContainer,
                      padding: const EdgeInsets.symmetric(
                        vertical: 25,
                        horizontal: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () => _onFormSubmitted(context),
                    child: Icon(
                      Platform.isIOS
                          ? FontAwesomeIcons.faceViewfinder
                          : FontAwesomeIcons.solidFingerprint,
                      size: 64,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: widget.moveToPasswordInput,
              child: Text("passwordUse".tr()),
            ),
          ],
        ),
      );

  Future _unregisterUser(BuildContext context) async {
    final success = await IdentityController.deleteUsername(
      context: context,
    );

    if (!context.mounted || !success) return;

    unawaited(
      context.router.replace(
        const UsernameInputRoute(),
      ),
    );
  }

  Future _onFormSubmitted(BuildContext context) async {
    final loginEntity = await AuthController.login(
      context: context,
      replaceCurrentRoute: false,
      params: LoginParams(
        biometricLogin: true,
      ),
    );

    if (!context.mounted || loginEntity == null) return;

    //loginEntity.moveToCorrespondingStep(context);
  }
}
