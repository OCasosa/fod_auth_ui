import "dart:async";

import "package:auto_route/auto_route.dart";
import "package:circular_countdown_timer/circular_countdown_timer.dart";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_flutter/features/fod_features.dart";

import "../../../../core/constants/theme/app_separators.dart";
import "../../../../core/routes/fod_auth_ui_router.gr.dart";

/// Content to be displayed when the user is locked
///
/// This widget is used to display the content when the user is locked.
/// This lock can be either a temporary lock or a permanent lock.
///
/// The content displayed is different depending on the lock type.
///
/// The temporary lock will show a message to the user indicating that the user is locked for a certain amount of time.
///
/// The permanent lock will show a message to the user indicating that the user is permanently locked.
class AccountLockContent extends StatelessWidget {
  /// Content to be displayed when the user is locked
  const AccountLockContent({
    required this.lockEntity,
    super.key,
  });

  /// Type of lock the user is in
  final AccountLockoutDataEntity lockEntity;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lockEntity.status.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  AppSeparators.kVSeparatorSmall,
                  Icon(
                    lockEntity.status.icon,
                    size: 36,
                    color: context.colorScheme.primary,
                  ),
                  AppSeparators.kVSeparator,
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        text: "userLockMessage".tr(
                          namedArgs: {
                            "time": lockEntity.status ==
                                    AccountLockEnum.LOCKED_TEMPORARY
                                ? "temporaly".tr()
                                : "permanently".tr(),
                          },
                        ),
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                        children: lockEntity.status ==
                                AccountLockEnum.LOCKED_TEMPORARY
                            ? [
                                const TextSpan(text: "\n\n"),
                                TextSpan(
                                  text: "tryAgainIn".tr(),
                                ),
                              ]
                            : [
                                const TextSpan(text: "\n\n"),
                                TextSpan(
                                  text: "customerServiceContact".tr(),
                                  style:
                                      context.textTheme.titleSmall?.copyWith(),
                                ),
                              ],
                      ),
                    ),
                    AppSeparators.kVSeparator,
                    if (lockEntity.lockedUntil <= 0) ...[
                      const SizedBox.shrink(),
                    ] else if (lockEntity.status ==
                            AccountLockEnum.LOCKED_TEMPORARY &&
                        lockEntity.lockedUntil <= 630) ...[
                      CircularCountDownTimer(
                        width: 80,
                        height: 80,
                        strokeWidth: 8,
                        strokeCap: StrokeCap.round,
                        duration: 630,
                        initialDuration: 630 - lockEntity.lockedUntil,
                        fillColor: context.colorScheme.primary,
                        ringColor: context.colorScheme.outline,
                        isReverse: true,
                        isReverseAnimation: true,
                        textStyle: TextStyle(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                      AppSeparators.kVSeparator,
                      Text(
                        "userTemporalLockWarningMessage".tr(),
                        style: context.textTheme.titleSmall?.copyWith(
                          color: context.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () => _unregisterUser(context),
                    child: Text("returnToLogin".tr()),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Future _unregisterUser(BuildContext context) async {
    final success = await IdentityController.deleteUsername(
      context: context,
    );

    if (!context.mounted || !success) return;

    unawaited(
      context.router.replace(
        const UsernameInputRoute(),
      ),
    );
  }
}
