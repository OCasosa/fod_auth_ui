import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

/// Entity to define the branding of the app
class BrandingPropsEntity {
  ///
  const BrandingPropsEntity({
    required this.logoImage,
    required this.homePage,
    this.background = const BackgroundPropsEntity(),
    this.appVersion,
  });

  /// Path to the brand logo image
  final String logoImage;

  /// Path to the login background image
  final BackgroundPropsEntity background;

  /// Page route info of the home page
  final PageRouteInfo homePage;

  /// Version of the app
  final String? appVersion;
}

/// Class to modify the sign in page background image
class BackgroundPropsEntity {
  /// Class to modify the sign in page background image
  const BackgroundPropsEntity({
    this.image,
    this.alignment = Alignment.topCenter,
    this.fit = BoxFit.cover,
  });

  /// Alignment of the background
  final AlignmentGeometry alignment;

  /// Fit of the background
  final BoxFit fit;

  /// path of the image
  final String? image;
}
