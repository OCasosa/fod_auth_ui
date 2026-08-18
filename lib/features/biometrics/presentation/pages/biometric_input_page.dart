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
    this.shouldShowBiometricDialog = false,
  });

  /// True if the biometric sensor should be automatically shown.
  final bool shouldShowBiometricDialog;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocProvider(
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
  Widget build(BuildContext context) => Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: SignInBackground(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FormSection(
              label: const AppVersionText(),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "welcomeTitle".tr(),
                              style: context.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          widget.user,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                        AppSeparators.kVSeparatorSmall,
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.initials,
                            style: context.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                backgroundColor:
                                    context.colorScheme.secondaryContainer,
                                foregroundColor:
                                    context.colorScheme.onSecondaryContainer,
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
                            const Spacer(),
                            TextButton(
                              onPressed: () => widget.moveToPasswordInput(),
                              child: Text(
                                "passwordUse".tr(),
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );

  Future _onFormSubmitted(BuildContext context) async {
    final loginEntity = await AuthController.login(
      context: context,
      replaceCurrentRoute: false,
      params: LoginParams(
        biometricLogin: true,
      ),
    );

    if (!context.mounted || loginEntity == null) return;

    if (loginEntity.trustedUser) {
      final token = await TokenController.obtainToken(
        context: context,
        isOTPValidation: false,
      );

      if (!context.mounted || token == null) return;

      if (token.data?.onboarding.isAuthorized ?? true) {
        unawaited(FodAuthUi.goToHome(context));

        return;
      } else {
        FodOnboarding.init(
          context: context,
          data: const OnboardingDataEntity(
            returnPage: PasswordInputRoute(),
          ),
          onboardingStatus: token.data?.onboarding.status ?? 0,
        );
      }

      return;
    }

    unawaited(
      context.router.replace(
        TwoFactorInputRoute(
          recipient: loginEntity.receiver ?? "",
        ),
      ),
    );
  }
}
