part of "../libraries/account_info_library.dart";

/// Page to display the account information of the user
@RoutePage()
class AccountInfoPage extends StatelessWidget {
  /// Page to display the account information of the user
  const AccountInfoPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CleanAppBar(
          title: Text(
            "information".tr().toCapitalized(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) => ProcurementDataLoadCubit(),
          child: const _AccountInfoContent(),
        ),
      );
}

class _AccountInfoContent extends StatelessWidget {
  const _AccountInfoContent();

  @override
  Widget build(BuildContext context) =>
      CubitWidgetStateBuilder<ProcurementDataLoadCubit, ProvisioningEntity>(
        onSuccess: (data) => RefreshIndicator.adaptive(
          onRefresh: () => _onRefresh(context),
          child: ListView(
            padding: AppSeparators.kPagePadding,
            children: [
              AccountCircleAvatar(
                initials: data.names,
              ),
              AppSeparators.kVSeparatorSmall,
              Text(
                "personal".tr().toCapitalized(),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppSeparators.kVSeparatorSmall,
              Card.outlined(
                child: Padding(
                  padding: AppSeparators.kCardPadding,
                  child: Column(
                    children: [
                      RowData(
                        title: "names".tr().toCapitalized(),
                        value: data.names,
                      ),
                      AppSeparators.kVSeparatorSmall,
                      RowData(
                        title: "fatherSurname".tr().toCapitalized(),
                        value: data.fatherSurname,
                      ),
                      AppSeparators.kVSeparatorSmall,
                      RowData(
                        title: "motherSurname".tr().toCapitalized(),
                        value: data.motherSurname,
                      ),
                      AppSeparators.kVSeparatorSmall,
                      RowData(
                        title: "CURP",
                        value: data.curp,
                      ),
                    ],
                  ),
                ),
              ),
              AppSeparators.kVSeparatorLarge,
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
                    children: [
                      RowData(
                        title: "phone".tr().toCapitalized(),
                        value: data.phone,
                      ),
                      AppSeparators.kVSeparatorSmall,
                      RowData(
                        title: "email".tr().toCapitalized(),
                        value: data.email,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onFailure: (failure) => FailureView(
          failure,
          onRetry: () => _onRefresh(context),
        ),
      );

  Future _onRefresh(BuildContext context) =>
      context.read<ProcurementDataLoadCubit>().getInfo();
}
