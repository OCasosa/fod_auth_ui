part of "biometrics_register_bottomsheet.dart";

/// Section that asks the user to store the password in
/// biometrics as long as a user has previously provided
/// its password
class _PasswordConfirmationSection extends StatelessWidget {
  /// Section that asks the user to store the password in
  /// biometrics as long as a user has previously provided
  /// its password
  const _PasswordConfirmationSection({
    required this.onConfirm,
    required this.onCancel,
  });

  /// Callback when the user confirms the password.
  final VoidCallback onConfirm;

  /// Callback when the user cancels the password.
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          BlockQuote(
            blockType: CardType.warning,
            message: "biometricWarningText".tr(),
          ),
          Expanded(
            child: Center(
              child: Icon(
                Platform.isAndroid
                    ? FontAwesomeIcons.fingerprint
                    : FontAwesomeIcons.faceViewfinder,
                size: 64,
                color: context.colorScheme.secondary,
              ),
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: context.colorScheme.outline,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: onCancel,
                    child: Text(
                      "cancel".tr().toCapitalized(),
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                AppSeparators.kHSeparatorSmall,
                Expanded(
                  flex: 1,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: onConfirm,
                    child: Text(
                      "confirm".tr().toCapitalized(),
                      style: context.textTheme.titleMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
