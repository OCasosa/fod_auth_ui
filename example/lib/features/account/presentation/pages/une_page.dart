import "package:auto_route/auto_route.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";

import "../../../../core/constants/theme/app_separators.dart";

import "../../../shared/presentation/widgets/data_display/row_data.dart";
import "../widgets/account_circle_avatar.dart";

/// Page that shows hours of work, contact data, etc.
@RoutePage()
class UnePage extends StatelessWidget {
  /// Page that shows hours of work, contact data, etc.
  const UnePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          forceMaterialTransparency: true,
          title: Text(
            "uneFullName".tr().toCapitalized(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
          ),
        ),
        body: ListView(
          padding: AppSeparators.kPagePadding,
          children: [
            const AccountCircleAvatar(
              initials: "ME",
            ),
            AppSeparators.kVSeparatorSmall,
            Text(
              "information".tr().toCapitalized(),
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSeparators.kVSeparatorSmall,
            Card.outlined(
              color: Colors.transparent,
              child: Padding(
                padding: AppSeparators.kCardPadding,
                child: Column(
                  spacing: 20,
                  children: [
                    RowData(
                      title: "schedule".tr().toCapitalized(),
                      value: "${DateFormat.E().format(
                        DateTime(
                          1900,
                          2,
                          5,
                        ),
                      )} - ${DateFormat.E().format(
                        DateTime(
                          1900,
                          2,
                          9,
                        ),
                      )}",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "09:00 - 14:00",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                        Text(
                          "|",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                        Text(
                          "15:00- 18:00",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                    RowData(
                      title: "headOffice".tr().toCapitalized(),
                      value: "MELISSA MENDOZA",
                    ),
                    RowData(
                      title: "enterprise".tr().toCapitalized(),
                      value: "Fintech on Demand, S.A. de C.V.",
                    ),
                  ],
                ),
              ),
            ),
            AppSeparators.kVSeparatorSmall,
            Text(
              "contact".tr().toCapitalized(),
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AppSeparators.kVSeparatorSmall,
            Card.outlined(
              color: Colors.transparent,
              child: Padding(
                padding: AppSeparators.kCardPadding,
                child: Column(
                  spacing: 20,
                  children: [
                    RowData(
                      title: "phone".tr().toCapitalized(),
                      value: "818 248 8265",
                    ),
                    RowData(
                      title: "email".tr().toCapitalized(),
                      value: "une@fintechondemand.mx",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
