import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/communication/business/enums/communication_channels_enum.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import "../../../../core/constants/theme/app_separators.dart";

/// Bottom sheet to select the communication channel
///
/// This bottom sheet is used to select the communication channel
/// to receive the OTP code.
class CommunicationChannelSelectBottomSheet extends StatelessWidget {
  /// Bottom sheet to select the communication channel
  const CommunicationChannelSelectBottomSheet({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "communicationProviderSelect".tr().toCapitalized(),
                  maxLines: 2,
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  "cancel".tr().toCapitalized(),
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          AppSeparators.kVSeparator,
          ...CommunicationChannelsEnum.values.map(
            (provider) => ListTile(
              title: Text(provider.name),
              subtitle: Text(
                provider.description,
              ),
              leading: FaIcon(
                provider.icon,
                size: 28,
              ),
              iconColor: context.colorScheme.secondary,
              horizontalTitleGap: 40,
              onTap: () => Navigator.of(context).pop(provider),
            ),
          ),
        ],
      );
}
