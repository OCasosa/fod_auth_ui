import "package:flutter_common_classes/errors/failure.dart";
import "package:fpdart/fpdart.dart";

/// Data operations for the Preferences collection
abstract class PreferencesRepository {
  /// Retrieves the theme brightness from the local data source
  Either<Failure, int> getThemeBrightness();

  /// Sets the theme brightness in the device storage
  Future<Either<Failure, bool>> setThemeBrightness({
    required int themeBrightness,
  });
}
