// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:one_wallet_business/features/account/presentation/libraries/account_info_library.dart'
    as _i2;
import 'package:one_wallet_business/features/account/presentation/libraries/account_menu_library.dart'
    as _i3;
import 'package:one_wallet_business/features/account/presentation/pages/bridges/account_bridge_page.dart'
    as _i1;
import 'package:one_wallet_business/features/account/presentation/pages/une_page.dart'
    as _i10;
import 'package:one_wallet_business/features/navigation/presentation/pages/tab_navigation_page.dart'
    as _i9;
import 'package:one_wallet_business/features/preferences/presentation/pages/select_languaje_page.dart'
    as _i6;
import 'package:one_wallet_business/features/preferences/presentation/pages/select_theme_page.dart'
    as _i7;
import 'package:one_wallet_business/features/shared/presentation/libraries/pdf_viewer_library.dart'
    as _i4;
import 'package:one_wallet_business/features/shared/presentation/libraries/security_information_library.dart'
    as _i5;
import 'package:one_wallet_business/features/splash/presentation/pages/splash_page.dart'
    as _i8;

/// generated route for
/// [_i1.AccountBridgePage]
class AccountBridgeRoute extends _i11.PageRouteInfo<void> {
  const AccountBridgeRoute({List<_i11.PageRouteInfo>? children})
      : super(AccountBridgeRoute.name, initialChildren: children);

  static const String name = 'AccountBridgeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AccountBridgePage();
    },
  );
}

/// generated route for
/// [_i2.AccountInfoPage]
class AccountInfoRoute extends _i11.PageRouteInfo<void> {
  const AccountInfoRoute({List<_i11.PageRouteInfo>? children})
      : super(AccountInfoRoute.name, initialChildren: children);

  static const String name = 'AccountInfoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.AccountInfoPage();
    },
  );
}

/// generated route for
/// [_i3.AccountMenuPage]
class AccountMenuRoute extends _i11.PageRouteInfo<void> {
  const AccountMenuRoute({List<_i11.PageRouteInfo>? children})
      : super(AccountMenuRoute.name, initialChildren: children);

  static const String name = 'AccountMenuRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.AccountMenuPage();
    },
  );
}

/// generated route for
/// [_i4.PdfViewerPage]
class PdfViewerRoute extends _i11.PageRouteInfo<PdfViewerRouteArgs> {
  PdfViewerRoute({
    required String fileName,
    String? base64File,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          PdfViewerRoute.name,
          args: PdfViewerRouteArgs(
            fileName: fileName,
            base64File: base64File,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PdfViewerRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PdfViewerRouteArgs>();
      return _i4.PdfViewerPage(
        fileName: args.fileName,
        base64File: args.base64File,
        key: args.key,
      );
    },
  );
}

class PdfViewerRouteArgs {
  const PdfViewerRouteArgs({required this.fileName, this.base64File, this.key});

  final String fileName;

  final String? base64File;

  final _i12.Key? key;

  @override
  String toString() {
    return 'PdfViewerRouteArgs{fileName: $fileName, base64File: $base64File, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PdfViewerRouteArgs) return false;
    return fileName == other.fileName &&
        base64File == other.base64File &&
        key == other.key;
  }

  @override
  int get hashCode => fileName.hashCode ^ base64File.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i5.SecurityInformationPage]
class SecurityInformationRoute extends _i11.PageRouteInfo<void> {
  const SecurityInformationRoute({List<_i11.PageRouteInfo>? children})
      : super(SecurityInformationRoute.name, initialChildren: children);

  static const String name = 'SecurityInformationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.SecurityInformationPage();
    },
  );
}

/// generated route for
/// [_i6.SelectLanguajePage]
class SelectLanguajeRoute extends _i11.PageRouteInfo<void> {
  const SelectLanguajeRoute({List<_i11.PageRouteInfo>? children})
      : super(SelectLanguajeRoute.name, initialChildren: children);

  static const String name = 'SelectLanguajeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.SelectLanguajePage();
    },
  );
}

/// generated route for
/// [_i7.SelectThemePage]
class SelectThemeRoute extends _i11.PageRouteInfo<void> {
  const SelectThemeRoute({List<_i11.PageRouteInfo>? children})
      : super(SelectThemeRoute.name, initialChildren: children);

  static const String name = 'SelectThemeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.SelectThemePage();
    },
  );
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
      : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashPage();
    },
  );
}

/// generated route for
/// [_i9.TabNavigationPage]
class TabNavigationRoute extends _i11.PageRouteInfo<void> {
  const TabNavigationRoute({List<_i11.PageRouteInfo>? children})
      : super(TabNavigationRoute.name, initialChildren: children);

  static const String name = 'TabNavigationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.TabNavigationPage();
    },
  );
}

/// generated route for
/// [_i10.UnePage]
class UneRoute extends _i11.PageRouteInfo<void> {
  const UneRoute({List<_i11.PageRouteInfo>? children})
      : super(UneRoute.name, initialChildren: children);

  static const String name = 'UneRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.UnePage();
    },
  );
}
