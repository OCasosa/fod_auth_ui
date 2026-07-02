import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/communication/business/enums/communication_channels_enum.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

/// Form field to select an otp provider via a bottom sheet
///
/// This field is used to select a provider from a list of providers
/// via a bottom sheet.
class CommunicationChannelBottomSheetFormField extends StatelessWidget {
  /// Form field that displays the catalogs in a bottom sheet
  const CommunicationChannelBottomSheetFormField({
    required this.name,
    this.onChanged,
    this.bottomSheetKey,
    super.key,
  });

  /// Name of the field in the form.
  final String name;

  /// Callback when the card is changed.
  final ValueChanged<CommunicationChannelsEnum?>? onChanged;

  /// Key to access the bottom sheet.
  final GlobalKey<FormBuilderDropdownSearchState<CommunicationChannelsEnum>>?
      bottomSheetKey;

  @override
  Widget build(BuildContext context) =>
      FormBuilderDropdownSearch<CommunicationChannelsEnum>(
        key: bottomSheetKey,
        name: name,
        items: (_, __) => CommunicationChannelsEnum.values,
        popupProps: PopupProps.modalBottomSheet(
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "communicationProviderSelect".tr().toCapitalized(),
              style: context.textTheme.titleMedium,
            ),
          ),
          showSelectedItems: true,
          showSearchBox: false,
          cacheItems: true,
          modalBottomSheetProps: const ModalBottomSheetProps(
            useRootNavigator: true,
          ),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              labelText: "search".tr().toCapitalized(),
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          itemBuilder: (context, item, isDisabled, isSelected, isPinned) =>
              ListTile(
            title: Text(item.name),
            leading: SizedBox(
              width: 50,
              child: Icon(item.icon),
            ),
            trailing: _getTrailingIcon(isSelected),
          ),
        ),
        decoration: InputDecoration(
          labelText: "communicationProviderSelect".tr().toCapitalized(),
          helperText: "communicationProviderHelperText".tr().toCapitalized(),
          helperMaxLines: 2,
        ),
        onChanged: onChanged,
        itemAsString: (item) => item.name,
        filterFn: (catalog, filter) => catalog.name.contains(filter),
        compareFn: (item1, item2) => item1 == item2,
      );

  Widget _getTrailingIcon(bool isSelected) => isSelected
      ? FaIcon(
          FontAwesomeIcons.solidCircleCheck,
          color: Colors.green.shade700,
        )
      : const SizedBox.shrink();
}
