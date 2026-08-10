import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:get_it/get_it.dart";
import "package:toastification/toastification.dart";

import "../../business/repositories/preferences_repository.dart";
import "../../business/use_cases/get_theme_brightness.dart";
import "../../business/use_cases/set_theme_brightness.dart";

/// State manager to handle the selection and changes between brightness (translated to [ThemeMode])
class CubitHelperSelectionRadi extends Cubit<ThemeMode> {
  /// The cubit needs a initialization, the default value is [system]
  CubitHelperSelectionRadi() : super(ThemeMode.system) {
    _loadInitialState();
  }

  void _loadInitialState() => GetThemeBrightness(
        preferencesRepository: GetIt.I<PreferencesRepository>(),
      ).call(params: const NoParams()).fold(
            (l) => l, // The default value is 'ThemeMode.system'
            (r) => safeEmit(ThemeMode.values[r]),
          );

  /// To change, needs a new value, set to the preferences,
  /// and emit the new value to the BlocBuilders
  Future<void> changeBrightness(
    ThemeMode brightness,
    BuildContext context,
  ) async {
    final res = await SetThemeBrightness(
      preferencesRepository: GetIt.I.get<PreferencesRepository>(),
    ).call(params: brightness.index);

    res.fold(
      (l) => toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text("error".tr()),
        description: Text(l.message),
      ),
      (r) => safeEmit(brightness),
    );
  }
}
