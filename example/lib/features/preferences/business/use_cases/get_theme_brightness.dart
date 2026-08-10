import "package:flutter_common_classes/constants/classes/params.dart";
import "package:flutter_common_classes/constants/classes/use_case.dart";
import "package:flutter_common_classes/errors/failure.dart";
import "package:fpdart/fpdart.dart";

import "../repositories/preferences_repository.dart";

/// Get the theme brightness from the local data source
class GetThemeBrightness extends UseCase<int, NoParams> {
  /// Get the theme brightness from the local data source
  GetThemeBrightness({
    required this.preferencesRepository,
  });

  /// Preferences repository
  final PreferencesRepository preferencesRepository;

  @override
  Either<Failure, int> call({
    required NoParams params,
  }) =>
      preferencesRepository.getThemeBrightness();
}
