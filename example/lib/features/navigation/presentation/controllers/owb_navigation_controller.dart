import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

/// Controller to manage the app navigation
///
/// This controller is used to open and close the app drawer
/// switching between the bottom navigation tabs
class OWBNavigationController {
  /// Controller to manage the app navigation
  OWBNavigationController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// The key of the scaffold
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  /// router for changing tabs
  late TabsRouter tabsRouter;

  /// Open the app drawer
  void openDrawer() => _scaffoldKey.currentState?.openDrawer();

  /// Close the app drawer
  void closeDrawer() => _scaffoldKey.currentState?.closeDrawer();
}
