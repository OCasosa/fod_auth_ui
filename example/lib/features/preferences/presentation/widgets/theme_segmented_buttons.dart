import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../cubits/cubit_helper_selection_radi.dart";

/// Theme buttons for selecting the theme mode.
class ThemeSegmentedButtons extends StatelessWidget {
  /// Theme buttons for selecting the theme mode.
  const ThemeSegmentedButtons({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CubitHelperSelectionRadi, ThemeMode>(
        builder: (context, themeMode) => SegmentedButton<ThemeMode>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment<ThemeMode>(
              value: ThemeMode.light,
              icon: FaIcon(FontAwesomeIcons.sunBright),
            ),
            ButtonSegment<ThemeMode>(
              value: ThemeMode.system,
              icon: FaIcon(FontAwesomeIcons.mobileScreen),
            ),
            ButtonSegment<ThemeMode>(
              value: ThemeMode.dark,
              icon: FaIcon(FontAwesomeIcons.moon),
            ),
          ],
          selected: {
            themeMode,
          },
          onSelectionChanged: (selection) {
            context.read<CubitHelperSelectionRadi>().changeBrightness(
                  selection.first,
                  context,
                );
          },
        ),
      );
}
