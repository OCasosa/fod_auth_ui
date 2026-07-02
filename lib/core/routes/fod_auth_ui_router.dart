import "package:auto_route/auto_route.dart";
import "package:fintech_on_demand_onboarding_flutter/core/routes/onboarding_router.dart";

import "fod_auth_ui_router.gr.dart";
import "names.dart";

/// App router.
@AutoRouterConfig(replaceInRouteName: "Page,Route")
class FODAuthUIRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: RoutesNames.userInput,
          page: UsernameInputRoute.page,
        ),
        AutoRoute(
          path: RoutesNames.passwordInput,
          page: PasswordInputRoute.page,
        ),
        AutoRoute(
          path: RoutesNames.passwordForgot,
          page: PasswordRecoverRoute.page,
        ),
        AutoRoute(
          path: RoutesNames.biometricInput,
          page: BiometricInputRoute.page,
        ),
        AutoRoute(
          path: RoutesNames.communicationVerification,
          page: CommunicationChannelVerificationRoute.page,
        ),
        AutoRoute(
          path: RoutesNames.otpInput,
          page: TwoFactorInputRoute.page,
        ),
        AutoRoute(
          path: RoutesNames.accountLocked,
          page: AccountLockRoute.page,
        ),
        ...OnboardingRouter().routes,
      ];
}
