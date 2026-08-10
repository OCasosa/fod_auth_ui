part of "../libraries/account_menu_library.dart";

class _AccountHeaderInfo extends StatelessWidget {
  const _AccountHeaderInfo();

  @override
  Widget build(BuildContext context) =>
      CubitWidgetStateBuilder<ProcurementDataLoadCubit, ProvisioningEntity>(
        onSuccess: (data) => Column(
          children: [
            AccountCircleAvatar(
              initials: data.names,
            ),
            AppSeparators.kVSeparatorSmall,
            Column(
              children: [
                Text(
                  data.fullName,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data.email,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ],
        ),
        // TODO: Handle loading with shimmer effect
        // TODO: Handle errors correctly
        onFailure: (failure) => Text(failure.message),
      );
}
