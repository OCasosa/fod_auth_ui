import "dart:io";

import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/features/identification/data/data_sources/local/keys/identification_local_data_keys.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart"
    hide EnvironmentConfig;
import "package:flutter_flavor/flutter_flavor.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:fod_auth_flutter/core/localization/auth_server_localizations.dart";
import "package:fod_auth_flutter/features/biometrics/data/data_sources/local/keys/biometrics_local_data_source_keys.dart";
import "package:fod_auth_flutter/features/identity/data/data_sources/local/keys/identity_local_data_source_keys.dart";
import "package:fod_auth_ui/core/config/fod_auth_ui_dependency_injection.dart";
import "package:fod_auth_ui/features/branding/business/entities/branding_props_entity.dart";
import "package:get_it/get_it.dart";
import "package:new_version_plus/new_version_plus.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../features/navigation/presentation/controllers/owb_navigation_controller.dart";
import "../../features/notification/notification.dart";
import "../../features/preferences/business/repositories/preferences_repository.dart";
import "../../features/preferences/data/data_sources/local/preferences_local_data_source.dart";
import "../../features/preferences/data/data_sources/local/preferences_local_data_source_keys.dart";
import "../../features/preferences/data/repositories/preferences_repository_impl.dart";

import "../constants/theme/material_theme.dart";
import "../gen/assets.gen.dart";
import "../routes/app_router.dart";
import "../routes/app_router.gr.dart";

/// Class to inject the dependencies in the application
class DependencyInjection {
  /// Inject the services in the application
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();

    HttpOverrides.global = HttpCertificateOverride();

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

    GetIt.I.registerSingleton<AppRouter>(AppRouter());

    GetIt.I.registerSingleton<FlutterSecureStorage>(
      SecureStorageService.initializeStorage,
    );

    final sharedPreferences =
        GetIt.I.registerSingleton<SharedPreferencesWithCache>(
      await SharedPreferencesWithCache.create(
        cacheOptions: SharedPreferencesWithCacheOptions(
          allowList: {
            ...PreferencesLocalDataSourceKeys().keys,
            ...BiometricsLocalDataSourceKeys().keys,
            ...IdentityLocalDataSourceKeys().keys,
            ...IdentificationLocalDataKeys().keys,
          },
        ),
      ),
    );

    GetIt.I.registerSingleton<PreferencesRepository>(
      PreferencesRepositoryImpl(
        localDataSource: PreferencesLocalDataSourceImpl(
          localSource: sharedPreferences,
        ),
      ),
    );
  }

  /// Inject the services in the application
  ///
  /// This injects the services when the application is running
  /// These services are loaded during the splash screen
  static Future injectServices() async {
    GetIt.I.registerSingleton<PackageInfo>(
      await PackageInfo.fromPlatform(),
    );

    await AuthServerLocalizations.loadTranslations();
  }

  /// Inject the repositories in the application
  ///
  /// This injects the repositories when the application is running
  /// These repositories are loaded during the splash screen
  // ignore: long-method
  static Future injectPublicRepositories() async {
    final sharedPreferencesInstance = GetIt.I.get<SharedPreferencesWithCache>();
    final internetInfo = NetworkInfoImpl(
      InternetConnection(),
    );

    GetIt.I.registerSingleton<PushNotificationRepository>(
      PushNotificationRepositoryImpl(
        localDataSource: PushNotificationLocalDataSourceImpl(
          sendProvider: FlutterLocalNotificationsPlugin(),
          backgroundColor: MaterialTheme.light.primaryColor,
        ),
      ),
    );

    GetIt.I.registerSingleton<OWBNavigationController>(
      OWBNavigationController(),
    );

    await FODAuthUIDependencyInjection.injectPublicRepositories(
      brandingProps: BrandingPropsEntity(
        logoImage: Assets.images.logos.appLogo.path,
        background: BackgroundPropsEntity(
          image: Assets.images.backgrounds.planes.path,
          alignment: Alignment.topCenter,
          fit: BoxFit.contain,
        ),
        homePage: const TabNavigationRoute(),
        appVersion: GetIt.I.get<PackageInfo>().version,
      ),
    );

    if (FlavorConfig.instance.name == Flavor.mock.name) {
      _injectMockRepositories();
    } else {
      _injectRealRepositories();
    }
  }

  /// Inject the repositories available only when the user is logged in
  static void injectPrivateRepositories() {
    // TODO: Separate private repos from public ones
  }

  static void _injectMockRepositories() {}

  static void _injectRealRepositories() {}
}
