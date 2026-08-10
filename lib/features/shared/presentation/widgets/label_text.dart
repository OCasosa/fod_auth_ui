import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

/// Displays a label with a child widget
class LabelText extends StatelessWidget {
  /// Displays a label with a child widget
  const LabelText({
    required this.title,
    required this.child,
    this.isRequired = true,
    this.icon,
    super.key,
  });

  /// Title of the field
  final String title;

  /// The child widget
  final Widget child;

  /// The icon to be displayed
  final IconData? icon;

  /// True if the field is required
  ///
  /// Displays a red asterisk next to the title
  final bool isRequired;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (icon != null)
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: FaIcon(
                          icon,
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    Expanded(
                      child: _LabelTitle(
                        showRequiredMark: isRequired,
                        label: title,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                child,
              ],
            ),
          ),
        ],
      );
}

class _LabelTitle extends StatelessWidget {
  const _LabelTitle({
    required this.label,
    required this.showRequiredMark,
  });

  /// True if the title should show an asterisk
  ///
  /// The asterisk is red and indicates that the field is required
  final bool showRequiredMark;

  /// Label of the title
  final String label;

  @override
  Widget build(BuildContext context) => showRequiredMark
      ? Row(
          children: [
            Text(
              label,
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              "*",
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.error,
              ),
            ),
          ],
        )
      : Text(
          label,
          style: context.textTheme.titleMedium?.copyWith(
            color: context.colorScheme.secondary,
          ),
        );
}
