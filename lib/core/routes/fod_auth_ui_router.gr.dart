// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i10;
import 'package:fod_auth_flutter/features/auth/business/entities/auth_password_page_info_entity.dart'
    as _i11;
import 'package:fod_auth_flutter/features/fod_features.dart' as _i12;
import 'package:fod_auth_flutter/features/security/business/entities/account_lockout_data_entity.dart'
    as _i9;
import 'package:fod_auth_ui/features/account/presentation/libraries/account_lock_page_library.dart'
    as _i1;
import 'package:fod_auth_ui/features/biometrics/presentation/libraries/biometric_input_library.dart'
    as _i2;
import 'package:fod_auth_ui/features/communication/libraries/communication_channel_verification_library.dart'
    as _i3;
import 'package:fod_auth_ui/features/identity/presentation/libraries/username_input_library.dart'
    as _i7;
import 'package:fod_auth_ui/features/otp/presentation/libraries/two_factor_input_library.dart'
    as _i6;
import 'package:fod_auth_ui/features/password/presentation/libraries/password_input_library.dart'
    as _i4;
import 'package:fod_auth_ui/features/password/presentation/libraries/password_recover_library.dart'
    as _i5;

/// generated route for
/// [_i1.AccountLockPage]
class AccountLockRoute extends _i8.PageRouteInfo<AccountLockRouteArgs> {
  AccountLockRoute({
    required _i9.AccountLockoutDataEntity lockEntity,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          AccountLockRoute.name,
          args: AccountLockRouteArgs(lockEntity: lockEntity, key: key),
          initialChildren: children,
        );

  static const String name = 'AccountLockRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AccountLockRouteArgs>();
      return _i1.AccountLockPage(lockEntity: args.lockEntity, key: args.key);
    },
  );
}

class AccountLockRouteArgs {
  const AccountLockRouteArgs({required this.lockEntity, this.key});

  final _i9.AccountLockoutDataEntity lockEntity;

  final _i10.Key? key;

  @override
  String toString() {
    return 'AccountLockRouteArgs{lockEntity: $lockEntity, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AccountLockRouteArgs) return false;
    return lockEntity == other.lockEntity && key == other.key;
  }

  @override
  int get hashCode => lockEntity.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i2.BiometricInputPage]
class BiometricInputRoute extends _i8.PageRouteInfo<BiometricInputRouteArgs> {
  BiometricInputRoute({
    _i10.Key? key,
    _i11.AuthPasswordPageInfoEntity? pageInfo,
    bool shouldShowBiometricDialog = false,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          BiometricInputRoute.name,
          args: BiometricInputRouteArgs(
            key: key,
            pageInfo: pageInfo,
            shouldShowBiometricDialog: shouldShowBiometricDialog,
          ),
          initialChildren: children,
        );

  static const String name = 'BiometricInputRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<BiometricInputRouteArgs>(
        orElse: () => const BiometricInputRouteArgs(),
      );
      return _i2.BiometricInputPage(
        key: args.key,
        pageInfo: args.pageInfo,
        shouldShowBiometricDialog: args.shouldShowBiometricDialog,
      );
    },
  );
}

class BiometricInputRouteArgs {
  const BiometricInputRouteArgs({
    this.key,
    this.pageInfo,
    this.shouldShowBiometricDialog = false,
  });

  final _i10.Key? key;

  final _i11.AuthPasswordPageInfoEntity? pageInfo;

  final bool shouldShowBiometricDialog;

  @override
  String toString() {
    return 'BiometricInputRouteArgs{key: $key, pageInfo: $pageInfo, shouldShowBiometricDialog: $shouldShowBiometricDialog}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BiometricInputRouteArgs) return false;
    return key == other.key &&
        pageInfo == other.pageInfo &&
        shouldShowBiometricDialog == other.shouldShowBiometricDialog;
  }

  @override
  int get hashCode =>
      key.hashCode ^ pageInfo.hashCode ^ shouldShowBiometricDialog.hashCode;
}

/// generated route for
/// [_i3.CommunicationChannelVerificationPage]
class CommunicationChannelVerificationRoute
    extends _i8.PageRouteInfo<CommunicationChannelVerificationRouteArgs> {
  CommunicationChannelVerificationRoute({
    required _i12.CommunicationChannelsEnum channel,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          CommunicationChannelVerificationRoute.name,
          args: CommunicationChannelVerificationRouteArgs(
            channel: channel,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CommunicationChannelVerificationRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CommunicationChannelVerificationRouteArgs>();
      return _i3.CommunicationChannelVerificationPage(
        channel: args.channel,
        key: args.key,
      );
    },
  );
}

class CommunicationChannelVerificationRouteArgs {
  const CommunicationChannelVerificationRouteArgs({
    required this.channel,
    this.key,
  });

  final _i12.CommunicationChannelsEnum channel;

  final _i10.Key? key;

  @override
  String toString() {
    return 'CommunicationChannelVerificationRouteArgs{channel: $channel, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CommunicationChannelVerificationRouteArgs) return false;
    return channel == other.channel && key == other.key;
  }

  @override
  int get hashCode => channel.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i4.PasswordInputPage]
class PasswordInputRoute extends _i8.PageRouteInfo<void> {
  const PasswordInputRoute({List<_i8.PageRouteInfo>? children})
      : super(PasswordInputRoute.name, initialChildren: children);

  static const String name = 'PasswordInputRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i4.PasswordInputPage();
    },
  );
}

/// generated route for
/// [_i5.PasswordRecoverPage]
class PasswordRecoverRoute extends _i8.PageRouteInfo<PasswordRecoverRouteArgs> {
  PasswordRecoverRoute({
    required String title,
    required String subtitle,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          PasswordRecoverRoute.name,
          args: PasswordRecoverRouteArgs(
            title: title,
            subtitle: subtitle,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'PasswordRecoverRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PasswordRecoverRouteArgs>();
      return _i5.PasswordRecoverPage(
        title: args.title,
        subtitle: args.subtitle,
        key: args.key,
      );
    },
  );
}

class PasswordRecoverRouteArgs {
  const PasswordRecoverRouteArgs({
    required this.title,
    required this.subtitle,
    this.key,
  });

  final String title;

  final String subtitle;

  final _i10.Key? key;

  @override
  String toString() {
    return 'PasswordRecoverRouteArgs{title: $title, subtitle: $subtitle, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PasswordRecoverRouteArgs) return false;
    return title == other.title &&
        subtitle == other.subtitle &&
        key == other.key;
  }

  @override
  int get hashCode => title.hashCode ^ subtitle.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i6.TwoFactorInputPage]
class TwoFactorInputRoute extends _i8.PageRouteInfo<TwoFactorInputRouteArgs> {
  TwoFactorInputRoute({
    required String recipient,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TwoFactorInputRoute.name,
          args: TwoFactorInputRouteArgs(recipient: recipient, key: key),
          initialChildren: children,
        );

  static const String name = 'TwoFactorInputRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TwoFactorInputRouteArgs>();
      return _i6.TwoFactorInputPage(recipient: args.recipient, key: args.key);
    },
  );
}

class TwoFactorInputRouteArgs {
  const TwoFactorInputRouteArgs({required this.recipient, this.key});

  final String recipient;

  final _i10.Key? key;

  @override
  String toString() {
    return 'TwoFactorInputRouteArgs{recipient: $recipient, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TwoFactorInputRouteArgs) return false;
    return recipient == other.recipient && key == other.key;
  }

  @override
  int get hashCode => recipient.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i7.UsernameInputPage]
class UsernameInputRoute extends _i8.PageRouteInfo<void> {
  const UsernameInputRoute({List<_i8.PageRouteInfo>? children})
      : super(UsernameInputRoute.name, initialChildren: children);

  static const String name = 'UsernameInputRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.UsernameInputPage();
    },
  );
}
