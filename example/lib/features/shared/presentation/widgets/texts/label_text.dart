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
  Widget build(BuildContext context) {
    final titleMediumStyle = context.textTheme.titleMedium;
    final lableStyle = titleMediumStyle?.copyWith(
      color: context.colorScheme.secondary,
    );

    Widget formTitle() => !isRequired
        ? Text(
            title,
            style: lableStyle,
          )
        : Row(
            children: [
              Text(
                title,
                style: lableStyle,
              ),
              const SizedBox(width: 5),
              Text(
                "*",
                style: titleMediumStyle?.copyWith(
                  color: context.colorScheme.error,
                ),
              ),
            ],
          );

    return Row(
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
                    child: formTitle(),
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
}
