import "package:flutter/material.dart";

/// Constants for separators used in the app
class AppSeparators {
  /// Default vertical separator for widgets
  static const kVSeparator = SizedBox(height: 30);

  /// Small vertical separator for widgets
  static const kVSeparatorSmall = SizedBox(height: 20);

  /// Large vertical separator for widgets
  static const kVSeparatorLarge = SizedBox(height: 50);

  /// Extra large vertical separator for widgets
  static const kVSeparatorExtraLarge = SizedBox(height: 70);

  /// Default horizontal separator for widgets
  static const kHSeparator = SizedBox(width: 30);

  /// Small horizontal separator for widgets
  static const kHSeparatorSmall = SizedBox(width: 20);

  /// Large horizontal separator for widgets
  static const kHSeparatorLarge = SizedBox(width: 50);

  /// Extra large horizontal separator for widgets
  static const kHSeparatorExtraLarge = SizedBox(width: 70);

  /// Page Padding
  static const kPagePadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 40,
  );

  /// App bar padding
  static const kAppBarPadding = EdgeInsets.only(
    left: 20,
    right: 20,
    top: 40,
  );

  /// Page Padding without vertical padding
  static const kPagePaddingNoVertical = EdgeInsets.symmetric(
    horizontal: 20,
  );

  /// Page Padding Without Horizontal padding
  static const kPagePaddingNoHorizontal = EdgeInsets.symmetric(
    vertical: 40,
  );

  /// Card Padding
  static const kCardPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 30,
  );

  /// Light-Card Padding
  static const kLightCardPadding = EdgeInsets.all(15);
}
