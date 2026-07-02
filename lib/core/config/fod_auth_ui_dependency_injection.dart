import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/core/config/onboarding_dependency_injection.dart";
import "package:fintech_on_demand_onboarding_flutter/features/identification/data/data_sources/local/keys/identification_local_data_keys.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart"
    hide EnvironmentConfig;
import "package:flutter_flavor/flutter_flavor.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:fod_auth_flutter/core/config/auth_dependency_injection.dart";
import "package:fod_auth_flutter/core/localization/auth_server_localizations.dart";
import "package:fod_auth_flutter/features/biometrics/data/data_sources/local/keys/biometrics_local_data_source_keys.dart";
import "package:fod_auth_flutter/features/communication/business/enums/communication_channels_enum.dart";
import "package:fod_auth_flutter/features/identity/data/data_sources/local/keys/identity_local_data_source_keys.dart";
import "package:fod_auth_flutter/features/security/business/entities/redirect_pages_entity.dart";
import "package:fod_auth_flutter/features/security/presentation/controllers/security_controller.dart";
import "package:get_it/get_it.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../features/branding/business/entities/branding_props_entity.dart";
import "../routes/fod_auth_ui_router.gr.dart";

/// Class to inject the dependencies in the application
class FODAuthUIDependencyInjection {
  /// Inject the services in the application
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    await injectCriticalServices();
  }

  /// Inject the critical services in the application
  ///
  /// This injects the services on the main thread
  /// WARNING: This method should be called before the application starts
  /// keep it simple so it doesn't take too long to execute
  static Future injectCriticalServices() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    GetIt.I.registerSingleton<FlutterSecureStorage>(
      SecureStorageService.initializeStorage,
    );

    GetIt.I.registerSingleton<SharedPreferencesWithCache>(
      await SharedPreferencesWithCache.create(
        cacheOptions: SharedPreferencesWithCacheOptions(
          allowList: {
            ...BiometricsLocalDataSourceKeys().keys,
            ...IdentityLocalDataSourceKeys().keys,
            ...IdentificationLocalDataKeys().keys,
          },
        ),
      ),
    );
  }

  /// Inject the services in the application
  ///
  /// This injects the services when the application is running
  /// These services are loaded during the splash screen
  static Future injectServices() async {
    await AuthServerLocalizations.loadTranslations();
  }

  /// Inject the repositories in the application
  ///
  /// This injects the repositories when the application is running
  /// These repositories are loaded during the splash screen
  // ignore: long-method
  static Future injectPublicRepositories({
    required BrandingPropsEntity brandingProps,
  }) async {
    GetIt.I.registerSingleton<BrandingPropsEntity>(brandingProps);

    GetIt.I.registerSingleton<SecurityController>(
      SecurityController(
        redirectPages: RedirectPagesEntity(
          mailValidatePage: CommunicationChannelVerificationRoute(
            channel: CommunicationChannelsEnum.email,
          ),
          phoneValidatePage: CommunicationChannelVerificationRoute(
            channel: CommunicationChannelsEnum.phone,
          ),
          passwordChangePage: PasswordRecoverRoute(
            title: "passwordUpdate".tr(),
            subtitle: "passwordSecurityUpdate".tr(),
          ),
          passwordInputPage: const PasswordInputRoute(),
          onAccountLocked: (lockout) => AccountLockRoute(lockEntity: lockout),
        ),
      ),
    );

    AuthDependencyInjection.injectRepositories();
    OnboardingDependencyInjection.injectRepositories();

    if (FlavorConfig.instance.name == Flavor.mock.name) {
      _injectMockRepositories();
    } else {
      _injectRealRepositories();
    }
  }

  /// Inject the repositories available only when the user is logged in
  static void injectPrivateRepositories() {}

  static void _injectMockRepositories() {}

  static void _injectRealRepositories() {}
}
