import "package:flutter/material.dart";

/// Helper class to get constant values for the app
class AppValues {
  /// The radius for small rounded corners
  static const kRoundedSmall = BorderRadius.all(Radius.circular(7));

  /// The radius for medium rounded corners
  static const kRoundedMedium = BorderRadius.all(Radius.circular(15));

  /// The radius for large rounded corners
  static const kRoundedMax = BorderRadius.all(Radius.circular(25));

  /// The radius for card rounded corners
  static const kCardRoundness = BorderRadius.all(Radius.circular(20));

  /// The radius for button rounded corners
  static const kBorderWidth = 2.0;

  /// The height of the app bar
  static const kAppBarHeight = 120.0;

  /// The height of the bottom bar
  static const kBottomBarHeight = 120.0;

  /// Supported locales for the app
  static const kSupportedLocales = [
    Locale("es"),
    // Locale("en"),
  ];
}
