import "dart:async";

import "package:shared_preferences/shared_preferences.dart";

import "preferences_local_data_source_keys.dart";

/// Local data source for the Preferences collection
abstract class PreferencesLocalDataSource {
  /// Retrieves the theme from the local data source
  /// 0 -> System
  /// 1 -> Light
  /// 2 -> Dark
  /// By default, the theme is set to 0 (System)
  int getThemeBrightness();

  /// Sets the theme in the device storage
  Future<bool> setThemeBrightness(int themeBrightness);
}

/// Local data source for the Preferences collection
class PreferencesLocalDataSourceImpl implements PreferencesLocalDataSource {
  /// Local data source for the Preferences collection
  PreferencesLocalDataSourceImpl({required this.localSource});

  /// Shared preferences instance
  final SharedPreferencesWithCache localSource;

  @override
  int getThemeBrightness() =>
      localSource
          .getInt(PreferencesLocalDataSourceKeys.cachedThemeBrightness) ??
      0;

  @override
  Future<bool> setThemeBrightness(int themeBrightness) async {
    await localSource.setInt(
      PreferencesLocalDataSourceKeys.cachedThemeBrightness,
      themeBrightness,
    );

    return true;
  }
}
