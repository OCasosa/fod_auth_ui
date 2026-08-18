part of "../libraries/password_change_library.dart";

/// Page where the logged in user can change their password.
@RoutePage()
class PasswordChangePage extends StatelessWidget {
  /// Page where the logged in user can change their password.
  const PasswordChangePage({
    required this.username,
    this.title,
    this.subtitle,
    super.key,
  });

  /// The title of the page.
  final String? title;

  /// The subtitle of the page.
  final String? subtitle;

  /// Name of the user
  final String username;

  @override
  Widget build(BuildContext context) {
    final effectiveTitle = title ?? "passwordUpdate".tr().toCapitalized();
    final effectiveSubtitle =
        subtitle ?? "passwordChangeFillFormText".tr().toCapitalized();

    return Scaffold(
      appBar: CleanAppBar(
        title: Text(
          effectiveTitle,
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: AppSeparators.kPagePadding,
        children: [
          Text(
            effectiveSubtitle,
            style: context.textTheme.titleMedium,
          ),
          AppSeparators.kVSeparator,
          PasswordChangeForm(
            username: username,
            onFormSubmit: (formEntity) => _onFormSubmit(
              context,
              formEntity,
            ),
          ),
        ],
      ),
    );
  }

  Future _onFormSubmit(
    BuildContext context,
    PasswordChangeFormEntity formEntity,
  ) async {
    final success = await PasswordController.changePassword(
      context: context,
      form: formEntity,
    );

    if (!context.mounted || !success) return;

    await context.router.maybePop(true);
  }
}
