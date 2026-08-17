part of "../libraries/two_factor_input_library.dart";

/// Page to input the two factor authentication code
///
/// The page begins with a loading state in which the otp code is sent primarily
/// by SMS. The user can also choose to receive the code by email.
@RoutePage()
class TwoFactorInputPage extends StatelessWidget {
  /// Page to input the two factor authentication code
  const TwoFactorInputPage({
    required this.recipient,
    super.key,
  });

  /// Initial recipient of the OTP
  final String recipient;

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CleanAppBar(
          leading: context.router.canPop()
              ? BackButton(
                  onPressed: () => _onBackPressed(context),
                )
              : null,
        ),
        body: BlocProvider(
          create: (context) => SendOTPStateCubit(
            initialData: LoginEntity(
              trustedUser: false,
              receiver: recipient,
            ),
          ),
          child: const _TwoFactorInputContent(),
        ),
      );

  void _onBackPressed(BuildContext context) {
    context.router.popUntilRoot();
  }
}

class _TwoFactorInputContent extends StatelessWidget {
  const _TwoFactorInputContent();

  @override
  Widget build(BuildContext context) =>
      CubitWidgetStateBuilder<SendOTPStateCubit, LoginEntity>(
        onSuccess: (entity) => _SuccessTwoFactorInputContent(
          entity.receiver ?? "",
        ),
        onFailure: (failure) => FailureView(
          failure,
          onRetry: () => context.read<SendOTPStateCubit>().getInfo(),
        ),
      );
}

class _SuccessTwoFactorInputContent extends StatelessWidget {
  const _SuccessTwoFactorInputContent(this.recipient);

  /// Recipient of the OTP code
  final String recipient;

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppSeparators.kPagePadding,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "otpEnter".tr(),
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AppSeparators.kVSeparatorSmall,
                  Text.rich(
                    TextSpan(
                      text: "otpSendBody".tr(),
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.outline,
                      ),
                      children: [
                        TextSpan(
                          text: " $recipient ",
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: "otpInput".tr(),
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: OTPForm(
                      listenForSmsCode:
                          context.read<SendOTPStateCubit>().value ==
                              CommunicationChannelsEnum.phone,
                      onFormSubmit: (form) => _onFormSubmit(context, form),
                      onOTPResend: () => _onOTPResend(
                        context,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Future _onFormSubmit(BuildContext context, OtpFormEntity form) async {
    await _promptBiometrics(context);
    if (!context.mounted) return;
    final token = await TokenController.obtainToken(
      context: context,
      otpForm: form,
      isOTPValidation: true,
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
  }

  Future _onOTPResend(BuildContext context) async {
    final newProvider = await showModalBottomSheet<CommunicationChannelsEnum>(
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (_) => const Padding(
        padding: AppSeparators.kPagePadding,
        child: CommunicationChannelSelectBottomSheet(),
      ),
    );

    if (newProvider == null || !context.mounted) return;

    context.read<SendOTPStateCubit>().setValueAndRefresh(newProvider);
  }

  Future<void> _promptBiometrics(BuildContext context) async {
    final biometricsRepository = GetIt.I.get<BiometricRepository>();

    final biometricsEnrolledResponse = GetBiometricEnrollment(
      repository: biometricsRepository,
    ).call(params: const NoParams());

    final biometricsEnrolled = biometricsEnrolledResponse.fold(
      (l) => false,
      (r) => r,
    );

    if (biometricsEnrolled) return;

    final promptFlagResponse =
        GetBiometricPromptFlag(repository: biometricsRepository).call(
      params: const NoParams(),
    );

    final flagPrompted = promptFlagResponse.fold(
      (l) => true,
      (r) => r,
    );

    if (flagPrompted) return;

    final biometricAvailableResponse = await GetBiometricsAvailable(
      repository: biometricsRepository,
    ).call(
      params: const NoParams(),
    );

    final biometricsAvailable = biometricAvailableResponse.fold(
      (l) => [],
      (r) => r,
    );

    if (!context.mounted || biometricsAvailable.isEmpty) return;

    await showBiometricsOverlay(
      context: context,
      toggle: true,
      retrievePasswordFromSession: true,
    );
  }
}
