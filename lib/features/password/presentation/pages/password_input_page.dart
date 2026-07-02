part of "../libraries/password_input_library.dart";

/// Page where the user inputs their password to login to the app.
///
/// This page is only accessible after the user has input their username.
/// Fallback page if the user fails to input their biometric data.
@RoutePage()
class PasswordInputPage extends StatelessWidget {
  /// Page where the user inputs their password to login to the app.
  ///
  /// This page is only accessible after the user has input their username.
  /// Fallback page if the user fails to input their biometric data.
  const PasswordInputPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: BlocProvider(
          create: (context) => AuthInfoStateCubit(),
          child: _PasswordInputContent(),
        ),
      );
}

class _PasswordInputContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      CubitWidgetStateBuilder<AuthInfoStateCubit, AuthPasswordPageInfoEntity>(
        onSuccess: (info) => _PasswordLoginContent(
          initials: info.maskedUsername,
          user: info.username,
        ),
        onFailure: (failure) => FailureView(
          failure,
          onRetry: () => context.read<AuthInfoStateCubit>().getInfo(),
        ),
      );
}

class _PasswordLoginContent extends StatelessWidget {
  const _PasswordLoginContent({
    required this.initials,
    required this.user,
  });

  /// User initials
  final String initials;

  /// User name
  final String user;

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
                            IconButton(
                              onPressed: () => _unregisterUser(context),
                              icon: FaIcon(
                                FontAwesomeIcons.arrowRightArrowLeft,
                                size: 16,
                                color: context.colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          user,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                        AppSeparators.kVSeparatorSmall,
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            initials,
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
                    child: _PasswordLoginInputForm(
                      onFormSubmitted: (password) => _onFormSubmitted(
                        context,
                        password,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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

  Future _onFormSubmitted(BuildContext context, String password) async {
    final loginEntity = await AuthController.login(
      context: context,
      replaceCurrentRoute: false,
      params: LoginParams(
        biometricLogin: false,
        password: password,
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
