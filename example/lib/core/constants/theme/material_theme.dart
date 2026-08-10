import "package:flex_color_scheme/flex_color_scheme.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

/// The [MaterialTheme] defines light and dark themes for the app.
///
/// Theme setup for FlexColorScheme package v8.
/// Use same major flex_color_scheme package version. If you use a
/// lower minor version, some properties may not be supported.
/// In that case, remove them after copying this theme to your
/// app or upgrade the package to version 8.2.0.
///
/// Use it in a [MaterialApp] like this:
///
/// MaterialApp(
///   theme: AppTheme.light,
///   darkTheme: AppTheme.dark,
/// );
abstract final class MaterialTheme {
  /// The FlexColorScheme defined light mode ThemeData.
  static ThemeData get light {
    final theme = FlexThemeData.light(
      // User defined custom colors made with FlexSchemeColor() API.
      colors: const FlexSchemeColor(
        primary: Color(0xFF1A4E9C),
        primaryContainer: Color(0xFFD0E4FF),
        secondary: Color(0xFF24AADD),
        secondaryContainer: Color(0xFFDDE1F9),
        tertiary: Color(0xFF68BB99),
        tertiaryContainer: Color(0xFF95F0FF),
        appBarColor: Color(0xFFDDE1F9),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
      ),
      // Input color modifiers.
      usedColors: 7,
      useMaterial3ErrorColors: true,
      // Component theme configurations for light mode.
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        useM2StyleDividerInM3: true,
        inputDecoratorSchemeColor: SchemeColor.surfaceContainer,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderSchemeColor: SchemeColor.secondary,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 16,
        inputDecoratorUnfocusedHasBorder: false,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),
      // Direct ThemeData properties.
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    );

    return theme.copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        errorMaxLines: 2,
      ),
    );
  }

  /// The FlexColorScheme defined dark mode ThemeData.
  static ThemeData get dark {
    final theme = FlexThemeData.dark(
      // Computing from light scheme using defaultError and toDark() methods.
      // User defined custom colors made with FlexSchemeColor() API.
      colors: const FlexSchemeColor(
        primary: Color(0xFF1A4E9C),
        primaryContainer: Color(0xFFD0E4FF),
        secondary: Color(0xFF24AADD),
        secondaryContainer: Color(0xFFDDE1F9),
        tertiary: Color(0xFF68BB99),
        tertiaryContainer: Color(0xFF95F0FF),
        appBarColor: Color(0xFFDDE1F9),
        error: Color(0xFFBA1A1A),
        errorContainer: Color(0xFFFFDAD6),
      ).defaultError.toDark(10, false),
      // Input color modifiers.
      usedColors: 7,
      useMaterial3ErrorColors: true,
      // Component theme configurations for dark mode.
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        blendOnColors: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        inputDecoratorRadius: 16,
        inputDecoratorUnfocusedHasBorder: false,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),
      // Direct ThemeData properties.
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    );

    return theme.copyWith(
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        errorMaxLines: 2,
      ),
    );
  }
}
