import "package:flutter/material.dart";
import "package:flutter_common_classes/extensions/theme_extension.dart";

import "../../../../core/constants/theme/app_separators.dart";

/// Widget that represents the bottom part of the login page, that is the form with the input
/// fields and the buttons
class FormSection extends StatelessWidget {
  /// Widget that represents the bottom part of the login page, that is the form with the input
  /// fields and the buttons
  const FormSection({
    required this.content,
    this.label,
    super.key,
  });

  /// List of widgets that goes below the subtitle/tertiary,
  /// that is the content of the form (optional)
  final Widget content;

  /// Optional widget to be placed at the top right corner of the card
  final Widget? label;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: label,
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.primary.withAlpha(50),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
              color: context.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: AppSeparators.kCardPadding,
              child: content,
            ),
          ),
        ],
      );
}
