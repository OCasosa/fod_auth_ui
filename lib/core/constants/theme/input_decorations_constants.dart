import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";

import "app_values.dart";

/// Class that contains the constants for the input decorations.
class InputDecorationsConstants {
  /// Creates a new instance of [InputDecorationsConstants].
  const InputDecorationsConstants(this.context);

  /// The [BuildContext] of the application.
  final BuildContext context;

  /// Creates a Borderless [InputDecoration] with the given [prefixIcon], [suffixIcon], and [labelText].
  InputDecoration createsBorderlessInputDecoration({
    required InputDecorationParameters parameters,
  }) =>
      InputDecoration(
        prefixIcon: parameters.prefixIcon,
        labelText: parameters.labelText,
        suffixIcon: parameters.suffixIcon,
        border: OutlineInputBorder(
          borderSide: parameters.borderSide,
          borderRadius: parameters.borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: parameters.borderSide,
          borderRadius: parameters.borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: parameters.borderSide,
          borderRadius: parameters.borderRadius,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: context.colorScheme.error,
          ),
          borderRadius: parameters.borderRadius,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: context.colorScheme.error,
          ),
          borderRadius: parameters.borderRadius,
        ),
        errorMaxLines: 2,
      );
}

/// Class that contains the parameters for the input decorations.
class InputDecorationParameters {
  /// Creates a new instance of [InputDecorationParameters].
  const InputDecorationParameters({
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.borderSide = BorderSide.none,
    this.borderRadius = AppValues.kRoundedMedium,
  });

  /// Label text inside the input field.
  final String labelText;

  /// Icon that appears at the beginning of the input field.
  final Widget? prefixIcon;

  /// Icon that appears at the end of the input field.
  final Widget? suffixIcon;

  /// Border side of the input field.
  final BorderSide borderSide;

  /// Border radius of the input field.
  final BorderRadius borderRadius;
}
