import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

/// The bottom navigation bar for the One Wallet Business app.
class OWBBottomNavBar extends StatelessWidget {
  /// The bottom navigation bar for the One Wallet Business app.
  const OWBBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) => BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: 0,
        onTap: (index) {},
        iconSize: 24,
        selectedIconTheme: IconThemeData(
          color: context.colorScheme.primary,
        ),
        unselectedIconTheme: IconThemeData(
          color: context.colorScheme.outline,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidHouse,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidPerson,
            ),
            label: "Account",
          ),
        ],
      );
}
