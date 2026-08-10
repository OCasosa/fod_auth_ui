import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";

/// A clean app bar widget that can be used in various pages.
class CleanAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// A clean app bar widget that can be used in various pages.
  const CleanAppBar({
    this.title,
    this.leading,
    super.key,
  });

  /// The title of the app bar.
  final Widget? title;

  /// The leading widget of the app bar.
  final Widget? leading;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => Theme(
        data: ThemeData(
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: context.colorScheme.onSurface,
              side: BorderSide(
                width: 1,
                color: context.isLightMode
                    ? context.colorScheme.outlineVariant
                    : context.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
        ),
        child: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: title,
          leading: leading,
        ),
      );
}
