import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:get_it/get_it.dart";

import "../../../branding/business/entities/branding_props_entity.dart";

/// Widget to display the app version
class AppVersionText extends StatelessWidget {
  /// Constructor for the widget
  const AppVersionText({super.key});

  @override
  Widget build(BuildContext context) {
    final version = GetIt.I.get<BrandingPropsEntity>().appVersion;

    return version == null
        ? const SizedBox.shrink()
        : Text(
            version,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.outline,
            ),
          );
  }
}
