part of "../libraries/username_input_library.dart";

/// Page where the user can register their username.
@RoutePage()
class UsernameInputPage extends StatelessWidget {
  /// Page where the user can register their username.
  const UsernameInputPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: _AuthPageContent(),
      );
}

class _AuthPageContent extends StatelessWidget {
  const _AuthPageContent();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: SignInBackground(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FormSection(
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "greetingTitle".tr(),
                            style: context.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          AppSeparators.kVSeparatorSmall,
                          Text(
                            "signInText".tr(),
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _UserLoginInputForm(
                        onFormSubmited: (user) {
                          _onFormSubmitted(user, context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Future _onFormSubmitted(String user, BuildContext context) async {
    final isSuccess = await IdentityController.setUsername(
      context: context,
      username: user,
    );

    if (!context.mounted || !isSuccess) return;

    unawaited(
      context.router.replace(
        const PasswordInputRoute(),
      ),
    );
  }
}
