import "package:flutter_common_classes/constants/classes/use_case.dart";
import "package:flutter_common_classes/errors/failure.dart";
import "package:fpdart/fpdart.dart";

import "../repositories/preferences_repository.dart";

/// Chenges theme brightness from the local data source
class SetThemeBrightness extends UseCaseAsync<bool, int> {
  /// Chenges theme brightness from the local data source
  SetThemeBrightness({
    required this.preferencesRepository,
  });

  /// Preferences repository
  final PreferencesRepository preferencesRepository;

  @override
  Future<Either<Failure, bool>> call({
    required int params,
  }) =>
      preferencesRepository.setThemeBrightness(
        themeBrightness: params,
      );
}
