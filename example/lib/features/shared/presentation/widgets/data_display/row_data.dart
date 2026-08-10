import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

/// Displays a row with an icon, title and value.
class RowData extends StatelessWidget {
  /// Displays a row with an icon, title and value.
  const RowData({
    required this.value,
    required this.title,
    this.icon,
    super.key,
  });

  /// The icon to display.
  final IconData? icon;

  /// The title to display.
  final String title;

  /// The value to display.
  final String value;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          if (icon != null) ...[
            FaIcon(
              icon,
              color: context.colorScheme.secondary,
            ),
            const SizedBox(width: 15),
          ] else
            ...[],
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: context.textTheme.titleSmall,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 3,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: context.textTheme.bodyMedium?.copyWith(
                color: context.colorScheme.outline,
              ),
            ),
          ),
        ],
      );
}
