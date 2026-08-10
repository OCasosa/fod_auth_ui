import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";

/// Shows a two-letter avatar for the account page.
class AccountCircleAvatar extends StatelessWidget {
  /// Shows a two-letter avatar for the account page.
  const AccountCircleAvatar({
    required this.initials,
    super.key,
  });

  /// The initials of the user.
  final String initials;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: 50,
        backgroundColor: context.colorScheme.surfaceContainerHigh,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: context.colorScheme.secondaryContainer,
          child: Text(
            initials.characters.getRange(0, 2).toString().toUpperCase(),
            style: context.textTheme.titleLarge,
          ),
        ),
      );
}
