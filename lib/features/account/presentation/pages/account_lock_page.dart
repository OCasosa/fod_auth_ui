part of "../libraries/account_lock_page_library.dart";

/// Page where the user is redirected when their account is locked.
@RoutePage()
class AccountLockPage extends StatelessWidget {
  /// Page where the user is redirected when their account is locked.
  const AccountLockPage({
    required this.lockEntity,
    super.key,
  });

  /// The information of the lockout
  final AccountLockoutDataEntity lockEntity;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: AccountLockContent(
          lockEntity: lockEntity,
        ),
      );
}
