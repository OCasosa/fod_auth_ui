import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/config/environment_config.dart"
    hide EnvironmentConfig;
import "package:fod_auth_ui/core/generated/fod_auth_ui_loader.gen.dart";

import "../core/config/dependency_injection.dart";
import "../core/config/environment_config.dart";
import "../core/constants/theme/app_values.dart";
import "../one_wallet_business_app.dart";

void main() async {
  EnvironmentConfig.init(
    flavor: Flavor.mock,
  );

  await DependencyInjection.init();

  runApp(
    EasyLocalization(
      supportedLocales: AppValues.kSupportedLocales,
      path: "assets/i18n",
      fallbackLocale: const Locale("es"),
      extraAssetLoaders: const [
        FodAuthUiLoader(),
      ],
      child: const OneWalletBusinessApp(
        appName: "One Wallet Business Local",
      ),
    ),
  );
}
