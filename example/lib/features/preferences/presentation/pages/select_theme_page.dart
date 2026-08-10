import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../shared/presentation/widgets/appbars/clean_appbar.dart";
import "../../business/entities/radio_select_option_entity.dart";
import "../cubits/cubit_helper_selection_radi.dart";

/// Page that can change the general theme of the app, same as the buttons of the drawer
/// in auth section
@RoutePage()
class SelectThemePage extends StatefulWidget {
  /// Page that can change the general theme of the app, same as the buttons of the drawer
  /// in auth section
  const SelectThemePage({super.key});

  @override
  State<SelectThemePage> createState() => _SelectThemePageState();
}

class _SelectThemePageState extends State<SelectThemePage> {
  final List<RadioSelectOptionEntity<ThemeMode>> _themes = [
    RadioSelectOptionEntity(
      title: "system".tr().toCapitalized(),
      leading: const _LeadingThemeIcon(FontAwesomeIcons.solidMobileScreen),
      value: ThemeMode.system,
    ),
    RadioSelectOptionEntity(
      title: "bright".tr().toCapitalized(),
      leading: const _LeadingThemeIcon(FontAwesomeIcons.solidSunBright),
      value: ThemeMode.light,
    ),
    RadioSelectOptionEntity(
      title: "dark".tr().toCapitalized(),
      leading: const _LeadingThemeIcon(FontAwesomeIcons.solidMoon),
      value: ThemeMode.dark,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CleanAppBar(
          title: Text(
            "theme".tr().toCapitalized(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocBuilder<CubitHelperSelectionRadi, ThemeMode>(
          builder: (context, state) => Padding(
            padding: AppSeparators.kPagePadding,
            child: Card(
              elevation: 0,
              color: context.colorScheme.surfaceContainerHigh,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: AppSeparators.kCardPadding,
                child: ListView.builder(
                  itemCount: _themes.length,
                  itemBuilder: (context, index) => RadioListTile(
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                    secondary: _themes[index].leading,
                    value: _themes[index].value,
                    groupValue: state,
                    title: Text(
                      _themes[index].title,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onChanged: (value) => cubitChangeBrightness(value ?? state),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Future<void> cubitChangeBrightness(ThemeMode newThemeMode) => context
      .read<CubitHelperSelectionRadi>()
      .changeBrightness(newThemeMode, context);
}

class _LeadingThemeIcon extends StatelessWidget {
  const _LeadingThemeIcon(this.icon);

  final IconData icon;

  @override
  Widget build(BuildContext context) => FaIcon(
        icon,
        size: 20,
        color: context.colorScheme.secondary,
      );
}
