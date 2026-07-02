import "package:auto_route/auto_route.dart";

/// Entity to define the branding of the app
class BrandingPropsEntity {
  ///
  const BrandingPropsEntity({
    required this.logoImage,
    required this.loginBackgroundImage,
    required this.homePage,
  });

  /// Path to the brand logo image
  final String logoImage;

  /// Path to the login background image
  final String loginBackgroundImage;

  /// Page route info of the home page
  final PageRouteInfo homePage;
}
