import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

/// Card info blockquote that displays a block of text with a vertical line on the left side, and an
/// Icon
class BlockQuote extends StatelessWidget {
  ///
  /// Creates a <blockquote> like HTML </blockquote>
  ///
  const BlockQuote({
    required this.message,
    super.key,
    this.blockType = CardType.info,
    this.blockWidth,
    this.childPadding,
  });

  ///
  /// The message text contained by the BlockQuote.
  ///
  ///
  final String message;

  ///
  /// BlockQuote's type, that translates into the color
  ///
  /// default to [CardType]'s `info`
  ///
  final CardType? blockType;

  ///
  /// BlockQuote's vertical line width
  ///
  /// default to `4.0`
  ///
  final double? blockWidth;

  ///
  /// BlockQuote's outer padding
  ///
  /// default to `const EdgeInsets.only(left: 15, top: 5, bottom: 5)`
  ///
  final EdgeInsetsGeometry? childPadding;
  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: blockType?.getBackgroundColor(context) ??
              context.colorScheme.primaryContainer,
          border: Border(
            left: BorderSide(
              color: blockType?.getBorderColor(context) ??
                  context.colorScheme.primary,
              width: blockWidth ?? 4.0,
            ),
          ),
        ),
        child: Padding(
          padding: childPadding ?? const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                blockType?.icon ?? Icons.info_outline,
                color: blockType?.getIconColor(context) ??
                    context.colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  message,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: blockType?.getTextColor(context) ??
                        context.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

/// Enum that defines the type of card
enum CardType {
  /// Info card
  info,

  /// Warning card
  warning,
}

/// Extension for the card type
extension CardTypeExtension on CardType {
  /// Get the icon for the card type
  IconData get icon {
    switch (this) {
      case CardType.info:
        return FontAwesomeIcons.circleInfo;

      case CardType.warning:
        return FontAwesomeIcons.triangleExclamation;
    }
  }

  /// Get the background color for the card type based on theme
  Color getBackgroundColor(BuildContext context) {
    switch (this) {
      case CardType.info:
        return context.colorScheme.brightness == Brightness.dark
            ? context.colorScheme.primaryContainer
            : context.colorScheme.primaryContainer.lighten(40);

      case CardType.warning:
        return context.colorScheme.brightness == Brightness.dark
            ? const Color(0xFFE65100).withValues(
                alpha: 0.3,
              )
            : const Color(0xFFFFF3E0);
    }
  }

  /// Get the border color for the card type based on theme
  Color getBorderColor(BuildContext context) {
    switch (this) {
      case CardType.info:
        return context.colorScheme.primary;

      case CardType.warning:
        return context.colorScheme.brightness == Brightness.dark
            ? const Color(0xFFFF9800)
            : const Color(0xFFE65100);
    }
  }

  /// Get the icon color for the card type based on theme
  Color getIconColor(BuildContext context) {
    switch (this) {
      case CardType.info:
        return context.colorScheme.brightness == Brightness.dark
            ? context.colorScheme.onPrimaryContainer
            : context.colorScheme.primaryContainer.darken(40);

      case CardType.warning:
        return context.colorScheme.brightness == Brightness.dark
            ? const Color(0xFFFFB74D)
            : const Color(0xFFBF360C);
    }
  }

  /// Get the text color for the card type based on theme
  Color getTextColor(BuildContext context) {
    switch (this) {
      case CardType.info:
        return context.colorScheme.brightness == Brightness.dark
            ? context.colorScheme.onPrimaryContainer
            : context.colorScheme.primaryContainer.darken(40);

      case CardType.warning:
        return context.colorScheme.brightness == Brightness.dark
            ? const Color(0xFFFFE0B2)
            : const Color(0xFFBF360C);
    }
  }

  /// Get the title for the card type
  String title() {
    switch (this) {
      case CardType.info:
        return "note".tr();

      case CardType.warning:
        return "warning".tr();
    }
  }
}
