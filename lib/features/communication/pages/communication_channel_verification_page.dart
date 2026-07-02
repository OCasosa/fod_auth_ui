part of "../libraries/communication_channel_verification_library.dart";

/// Page where the user must input the verification code sent to their email.
@RoutePage()
class CommunicationChannelVerificationPage extends StatelessWidget {
  /// Page where the user must input the verification code sent to their email.
  const CommunicationChannelVerificationPage({
    required this.channel,
    super.key,
  });

  /// Communication channel being verified.
  final CommunicationChannelsEnum channel;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CleanAppBar(
          leading: BackButton(
            onPressed: () => _onBackPressed(context),
          ),
        ),
        body: BlocProvider(
          create: (context) => CommunicationChannelVerificationCubit(
            channel: channel,
          ),
          child: const _CommunicationChannelVerificationContent(),
        ),
      );

  void _onBackPressed(BuildContext context) {
    context.router.popUntilRoot();
  }
}

class _CommunicationChannelVerificationContent extends StatelessWidget {
  const _CommunicationChannelVerificationContent();

  @override
  Widget build(BuildContext context) => CubitWidgetStateBuilder<
          CommunicationChannelVerificationCubit,
          CommunicationChannelRequestVerificationEntity>(
        onSuccess: (masked) => _SuccessContent(
          entity: masked,
        ),
        onFailure: (failure) => FailureView(
          failure,
          onRetry: () => _onRetry(context),
        ),
      );

  void _onRetry(BuildContext context) =>
      context.read<CommunicationChannelVerificationCubit>().getInfo();
}

class _SuccessContent extends StatelessWidget {
  const _SuccessContent({
    required this.entity,
  });

  // Entity that contains the values when an OTP was sent
  final CommunicationChannelRequestVerificationEntity entity;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 40,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Text(
                    "communicationProviderVerification".tr(
                      namedArgs: {
                        "channel": context
                            .read<CommunicationChannelVerificationCubit>()
                            .channel
                            .name,
                      },
                    ),
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  AppSeparators.kVSeparator,
                  Text(
                    "communicationCodeEnter".tr(),
                    style: context.textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  AppSeparators.kVSeparatorSmall,
                  Text(
                    entity.receiver,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: SafeArea(
                child: OTPForm(
                  onFormSubmit: (form) => _onFormSubmitted(
                    context: context,
                    form: form,
                  ),
                  onOTPResend: () => _onOTPResend(context),
                  listenForSmsCode: context
                          .read<CommunicationChannelVerificationCubit>()
                          .channel ==
                      CommunicationChannelsEnum.phone,
                ),
              ),
            ),
          ],
        ),
      );

  void _onOTPResend(BuildContext context) {
    context.read<CommunicationChannelVerificationCubit>().getInfo();
  }

  Future _onFormSubmitted({
    required BuildContext context,
    required OtpFormEntity form,
  }) async {
    final loginEntity = await CommunicationChannelController.verifyChannel(
      context: context,
      form: CommunicationChannelVerificationParams(
        channel: context.read<CommunicationChannelVerificationCubit>().channel,
        otpFormEntity: form,
      ),
    );

    if (!context.mounted || loginEntity == null) return;

    if (loginEntity.trustedUser) {
      final token = await TokenController.obtainToken(
        context: context,
        otpForm: form,
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
    } else {
      unawaited(
        context.router.push(
          TwoFactorInputRoute(
            recipient: loginEntity.receiver ?? "",
          ),
        ),
      );
    }
  }
}
