import "package:auto_route/auto_route.dart";
import "package:fod_auth_ui/core/routes/fod_auth_ui_router.dart";

import "app_router.gr.dart";
import "routes_names.dart";

/// App router.
@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        ..._initialRoutes,
        ...FODAuthUIRouter().routes,
        AutoRoute(
          page: TabNavigationRoute.page,
          children: _appMainRoutes,
        ),
        AutoRoute(
          path: RoutesNames.pdfView,
          page: PdfViewerRoute.page,
        ),
        AutoRoute(
          path: RoutesNames.une,
          page: UneRoute.page,
        ),
      ];

  static final List<AutoRoute> _initialRoutes = [
    AutoRoute(
      path: RoutesNames.splash,
      page: SplashRoute.page,
    ),
  ];

  static final List<AutoRoute> _accountRoutes = [
    AutoRoute(
      page: AccountMenuRoute.page,
      path: RoutesNames.myAccountPage,
      initial: true,
    ),
    AutoRoute(
      page: AccountInfoRoute.page,
      path: RoutesNames.personalInfo,
    ),
    AutoRoute(
      page: SelectLanguajeRoute.page,
      path: RoutesNames.languaje,
    ),
    AutoRoute(
      page: SelectThemeRoute.page,
      path: RoutesNames.theme,
    ),
    AutoRoute(
      page: SecurityInformationRoute.page,
      path: RoutesNames.securityGuidelines,
    ),
  ];

  static final List<AutoRoute> _appMainRoutes = [
    AutoRoute(
      initial: true,
      path: RoutesNames.account,
      page: AccountBridgeRoute.page,
      children: _accountRoutes,
    ),
  ];
}
