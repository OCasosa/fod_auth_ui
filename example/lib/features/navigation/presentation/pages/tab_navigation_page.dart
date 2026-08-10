import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:fod_auth_flutter/features/auth/business/entities/auth_step_enum.dart";
import "package:fod_auth_flutter/features/inactivity/presentation/inactivity_manager.dart";
import "package:fod_auth_flutter/features/security/presentation/bindings/connectivity_change_binding.dart";
import "package:fod_auth_flutter/features/session/presentation/bindings/auto_refresh_session_binding.dart";
import "package:fod_auth_ui/fod_auth_ui.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get_it/get_it.dart";

import "../../../../core/routes/app_router.gr.dart";
import "../../../notification/notification.dart";
import "../../../notification/presentation/controllers/push_notification_controller.dart";
import "../controllers/owb_navigation_controller.dart";

/// Page in charge of building the persistent bottom navigation and the nested
/// navigation logic
///
/// This page is parent of all next subpages
@RoutePage()
class TabNavigationPage extends StatelessWidget {
  /// Page in charge of building the persistent bottom navigation and the nested
  /// navigation logic
  ///
  /// This page is parent of all next subpages
  const TabNavigationPage({super.key});

  @override
  Widget build(BuildContext context) => ConnectivityChangeBinding(
        onConnectionLogout: (step) => _onLogout(context, step),
        child: AutoRefreshSessionBinding(
          onError: (error) => _onLogout(context, error),
          child: InactivityManager(
            timeBeforeDialog: const Duration(minutes: 4),
            onAppBackground: _onAppBackground,
            onAppResume: _onAppResume,
            onLoggout: (step) => _onLogout(context, step),
            child: AutoTabsRouter.tabBar(
              physics: const NeverScrollableScrollPhysics(),
              routes: const [
                AccountBridgeRoute(),
                AccountBridgeRoute(),
              ],
              builder: (context, child, _) {
                final tabsRouter = AutoTabsRouter.of(context);
                GetIt.I<OWBNavigationController>().tabsRouter = tabsRouter;

                return Scaffold(
                  key: GetIt.I<OWBNavigationController>().scaffoldKey,
                  body: child,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
                  bottomNavigationBar: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: BottomAppBar(
                        shape: const CircularNotchedRectangle(),
                        notchMargin: 5,
                        padding: EdgeInsets.zero,
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          currentIndex: tabsRouter.activeIndex,
                          onTap: (i) => _onBottomNavigationTap(
                            context: context,
                            value: i,
                          ),
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          items: const [
                            BottomNavigationBarItem(
                              label: "inicio",
                              icon: Icon(
                                FontAwesomeIcons.solidHouse,
                              ),
                            ),
                            BottomNavigationBarItem(
                              label: "cuenta",
                              icon: Icon(
                                FontAwesomeIcons.solidUser,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );

  void _onBottomNavigationTap({
    required int value,
    required BuildContext context,
  }) =>
      AutoTabsRouter.of(context).setActiveIndex(value);

  void _onLogout(BuildContext context, AuthStep? value) =>
      FodAuthUi.goToAuth(context: context);

  Future _onAppBackground(Duration value) async {
    PushNotificationController.sendLocalPushNotification(
      params: SendLocalPushNotificationParams(
        title: "sessionExpired".tr(),
        message: "sessionExpiredDueToInactivity".tr(),
        delay: value,
      ),
    );
  }

  Future<void> _onAppResume() async {
    PushNotificationController.cancelAllNotifications();
  }
}
