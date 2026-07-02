import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

import "../../../branding/business/entities/branding_props_entity.dart";

/// Widget that represents the top of the login part, that is the background with the logo of the
/// app, and a simple background image
class SignInBackground extends StatelessWidget {
  /// Widget that represents the top of the login part, that is the background with the logo of the
  /// app, and a simple background image
  const SignInBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final backgroundImage = _retrieveBackground();
    final appLogo = _retrieveAppLogo();

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 40,
      ),
      decoration: BoxDecoration(
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Center(
        child: appLogo != null
            ? Image.asset(
                appLogo,
                // TODO: Check this size for different devices
                height: MediaQuery.of(context).size.height * 0.35,
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  String? _retrieveBackground() {
    try {
      return GetIt.I.get<BrandingPropsEntity>().loginBackgroundImage;
    } catch (e) {
      return null;
    }
  }

  String? _retrieveAppLogo() {
    try {
      return GetIt.I.get<BrandingPropsEntity>().logoImage;
    } catch (e) {
      return null;
    }
  }
}
