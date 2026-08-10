import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:svg_flag/svg_flag.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../shared/presentation/widgets/appbars/clean_appbar.dart";
import "../../business/entities/radio_select_option_entity.dart";

/// Page that shows the list of possible languajes to change in app
@RoutePage()
class SelectLanguajePage extends StatefulWidget {
  /// Page that shows the list of possible languajes to change in app
  const SelectLanguajePage({super.key});

  @override
  State<SelectLanguajePage> createState() => _SelectLanguajePageState();
}

class _SelectLanguajePageState extends State<SelectLanguajePage> {
  final List<RadioSelectOptionEntity<int>> _languajes = [
    RadioSelectOptionEntity(
      title: "english".tr().toCapitalized(),
      leading: const _LeadingIcon("US"),
      value: 0,
    ),
    RadioSelectOptionEntity(
      title: "spanish".tr().toCapitalized(),
      leading: const _LeadingIcon("ES"),
      value: 1,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CleanAppBar(
          title: Text(
            "language".tr().toCapitalized(),
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: AppSeparators.kPagePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: SearchBar(
                  elevation: const WidgetStatePropertyAll(0),
                  hintText: "search".tr().toCapitalized(),
                  hintStyle: WidgetStatePropertyAll(
                    context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.outlineVariant,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: context.colorScheme.outline,
                  ),
                  padding: const WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              AppSeparators.kVSeparatorSmall,
              Expanded(
                flex: 7,
                child: Card(
                  elevation: 0,
                  color: context.colorScheme.surfaceContainerHigh,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: AppSeparators.kCardPadding,
                    child: ListView.builder(
                      itemCount: _languajes.length,
                      itemBuilder: (context, index) => RadioListTile(
                        controlAffinity: ListTileControlAffinity.trailing,
                        contentPadding: EdgeInsets.zero,
                        secondary: _languajes[index].leading,
                        value: _languajes[index].value,
                        groupValue: 0,
                        title: Text(
                          _languajes[index].title,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onChanged: (_) {
                          // TODO: Implement languaje change
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}

class _LeadingIcon extends StatelessWidget {
  const _LeadingIcon(this.countryCode);

  final String countryCode;

  @override
  Widget build(BuildContext context) => SvgFlag(
        FlagData.parse(code: countryCode),
        height: 20,
      );
}
