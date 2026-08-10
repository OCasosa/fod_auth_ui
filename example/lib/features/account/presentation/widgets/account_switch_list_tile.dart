part of "../libraries/account_menu_library.dart";

/// A widget that represents a list tile with a switch trailing widget for an account setting
class _AccountSwitchListTile extends StatefulWidget {
  /// A widget that represents a list tile for an account setting
  const _AccountSwitchListTile({
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.initialValue,
    required this.onChanged,
  });

  /// The title of the list tile
  final String title;

  /// The icon data to be displayed left of the title
  final IconData iconData;

  /// The color of the icon
  final Color iconColor;

  /// The callback function to be executed when the list tile is tapped
  final Future<bool> Function(bool) onChanged;

  /// Initial value
  final bool initialValue;

  @override
  State<_AccountSwitchListTile> createState() => _AccountSwitchListTileState();
}

class _AccountSwitchListTileState extends State<_AccountSwitchListTile> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) => SwitchListTile.adaptive(
        value: _value,
        contentPadding: const EdgeInsets.only(
          left: 16,
        ),
        secondary: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: FaIcon(
            widget.iconData,
            size: 20,
            color: widget.iconColor,
          ),
        ),
        title: Text(
          widget.title,
          style: context.textTheme.titleMedium,
        ),
        onChanged: (value) async {
          final initialValue = _value;
          setState(() {
            _value = value;
          });

          final result = await widget.onChanged(value);

          if (!result) {
            setState(() {
              _value = initialValue;
            });
          }
        },
      );
}
