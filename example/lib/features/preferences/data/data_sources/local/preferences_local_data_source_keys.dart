import "package:flutter_common_classes/constants/classes/local_data_source_keys.dart";

/// Keys for the local data source for the onboarding process
class PreferencesLocalDataSourceKeys implements LocalDataSourceKeys {
  /// Key for storing the theme brightness
  static const cachedThemeBrightness = "THEME_BRIGHTNESS";

  @override
  Set<String> get keys => {
        cachedThemeBrightness,
      };
}
