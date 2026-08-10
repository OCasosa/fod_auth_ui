import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";

/// A secondary text button.
class TextButtonSecondary extends StatelessWidget {
  /// A secondary text button.
  const TextButtonSecondary({
    required this.onPressed,
    required this.title,
    super.key,
    this.isExpanded = false,
    this.verticalSeparation = 10,
  });

  /// Action to execute when the button is pressed.
  final VoidCallback onPressed;

  /// The title of the button.
  final String title;

  /// True if the button should expand to fill the available space.
  final bool isExpanded;

  /// The vertical separation between the button and adjacent widgets
  final double verticalSeparation;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: verticalSeparation),
        child: TextButton(
          style: TextButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: isExpanded ? const Size.fromHeight(25) : null,
          ),
          onPressed: onPressed,
          child: Text(
            title,
            style: context.textTheme.labelMedium?.copyWith(
              color: context.colorScheme.secondary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
}
