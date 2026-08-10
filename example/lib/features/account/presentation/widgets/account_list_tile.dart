part of "../libraries/account_menu_library.dart";

/// A widget that represents a list tile for an account setting
class _AccountListTile extends StatelessWidget {
  /// A widget that represents a list tile for an account setting
  const _AccountListTile({
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.onTap,
  });

  /// The title of the list tile
  final String title;

  /// The icon data to be displayed left of the title
  final IconData iconData;

  /// The color of the icon
  final Color iconColor;

  /// The callback function to be executed when the list tile is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        trailing: FaIcon(
          FontAwesomeIcons.chevronRight,
          size: 16,
          color: context.colorScheme.outline,
        ),
        leading: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FaIcon(
            iconData,
            size: 20,
            color: iconColor,
          ),
        ),
        title: Text(
          title,
          style: context.textTheme.titleMedium,
        ),
        onTap: onTap,
      );
}
