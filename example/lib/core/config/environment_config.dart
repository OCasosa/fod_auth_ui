import "package:fintech_on_demand_onboarding_flutter/core/config/onboarding_environment_config.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/config/environment_config.dart";
import "package:flutter_flavor/flutter_flavor.dart";
import "package:fod_auth_flutter/core/config/auth_environment_config.dart";

/// A class that provides the environment configuration for the application.
///
/// This class is used to set the environment variables for the application.
class EnvironmentConfig {
  /// Initializes the environment configuration.
  static void init({
    required Flavor flavor,
  }) {
    FlavorConfig(
      name: flavor.name != "production" ? flavor.name : null,
      color: Colors.red,
      location: BannerLocation.topStart,
      variables: _getVariables(flavor),
    );
  }

  static Map<String, dynamic> _getVariables(Flavor flavor) {
    final onboardingVariables =
        OnboardingEnvironmentConfig.getVariables(flavor);
    final authVariables = AuthEnvironmentConfig.getVariables(flavor);

    final appVariables = switch (flavor) {
      Flavor.mock => _mockVariables,
      Flavor.local => _localVariables,
      Flavor.test => _testVariables,
      Flavor.production => _prodVariables,
      Flavor.preProduction => _preProdVariables,
    };

    return {
      ...onboardingVariables,
      ...authVariables,
      ...appVariables,
    };
  }

  static const Map<String, dynamic> _mockVariables = {};

  static const Map<String, dynamic> _localVariables = {};

  static const Map<String, dynamic> _testVariables = {};

  static const Map<String, dynamic> _preProdVariables = {};

  static const Map<String, dynamic> _prodVariables = {};
}
