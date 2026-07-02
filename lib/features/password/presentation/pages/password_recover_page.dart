part of "../libraries/password_recover_library.dart";

/// Page where the user can recover their password if forgotten.
///
/// The user must have available providers to recover their password, because
/// an OTP will be sent to one of them.
@RoutePage()
class PasswordRecoverPage extends StatelessWidget {
  /// Page where the user can recover their password if forgotten.
  const PasswordRecoverPage({
    required this.title,
    required this.subtitle,
    super.key,
  });

  /// The title of the page.
  final String title;

  /// The subtitle of the page.
  final String subtitle;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CleanAppBar(),
        body: ListView(
          padding: AppSeparators.kPagePadding,
          children: [
            Text(
              subtitle,
              style: context.textTheme.titleMedium,
            ),
            AppSeparators.kVSeparator,
            PasswordRecoverForm(
              onFormSubmit: (formEntity, otpFormEntity) => _onFormSubmit(
                context,
                formEntity,
                otpFormEntity,
              ),
            ),
          ],
        ),
      );

  Future _onFormSubmit(
    BuildContext context,
    RecoverPasswordFormEntity formEntity,
    OtpFormEntity otpFormEntity,
  ) async {
    final loginEntity = await PasswordController.recoverPassword(
      context: context,
      formEntity: formEntity,
      otpFormEntity: otpFormEntity,
    );

    if (!context.mounted || loginEntity == null) return;

    if (loginEntity.trustedUser) {
      final token = await TokenController.obtainToken(
        context: context,
        otpForm: otpFormEntity,
        isOTPValidation: false,
      );

      if (!context.mounted || token == null) return;

      if (token.data?.onboarding.isAuthorized ?? true) {
        unawaited(FodAuthUi.goToHome(context));
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
