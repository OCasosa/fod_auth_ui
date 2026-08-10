import "package:flutter_common_classes/errors/failure.dart";
import "package:fpdart/fpdart.dart";

import "../../../../core/errors/error_handler.dart";
import "../../business/repositories/preferences_repository.dart";
import "../data_sources/local/preferences_local_data_source.dart";

/// Data operations for the Preferences collection
class PreferencesRepositoryImpl implements PreferencesRepository {
  /// Data operations for the Preferences collection
  PreferencesRepositoryImpl({
    required this.localDataSource,
  });

  /// Local data source for the Preferences collection
  final PreferencesLocalDataSource localDataSource;

  @override
  Either<Failure, int> getThemeBrightness() =>
      ErrorHandler.handleCacheCall<int>(
        localDataSource.getThemeBrightness,
      );

  @override
  Future<Either<Failure, bool>> setThemeBrightness({
    required int themeBrightness,
  }) =>
      ErrorHandler.handleCacheCallAsync(
        () => localDataSource.setThemeBrightness(themeBrightness),
      );
}
