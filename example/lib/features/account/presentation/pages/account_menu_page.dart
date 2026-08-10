part of "../libraries/account_menu_library.dart";

/// Page that shows the user's account information and other settings.
@RoutePage()
class AccountMenuPage extends StatelessWidget {
  /// Page that shows the user's account information and other settings.
  const AccountMenuPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CleanAppBar(
          title: Text(
            "account".tr().toCapitalized(),
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.doorOpen,
              size: 18,
              color: context.colorScheme.error,
            ),
            onPressed: () => _onLogout(context),
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProcurementDataLoadCubit(),
            ),
            BlocProvider(
              create: (context) => LastLoginLoadCubit(),
            ),
          ],
          child: const _AccountMenuContent(),
        ),
      );

  Future _onLogout(BuildContext context) => FodAuthUi.logout(
        context,
        askUserForConfirmation: true,
      );
}

class _AccountMenuContent extends StatelessWidget {
  const _AccountMenuContent();

  @override
  Widget build(BuildContext context) => RefreshIndicator.adaptive(
        onRefresh: () => _onRefresh(context),
        child: ListView(
          padding: AppSeparators.kPagePadding,
          children: [
            const _AccountHeaderInfo(),
            AppSeparators.kVSeparator,
            _AccountListTile(
              title: "information".tr().toCapitalized(),
              iconData: FontAwesomeIcons.user,
              iconColor: const Color(0xFF2FA2B9),
              onTap: () => _onInfoSelected(context),
            ),
            // _AccountListTile(
            //   title: "language".tr().toCapitalized(),
            //   iconData: FontAwesomeIcons.globe,
            //   iconColor: const Color(0xFF5FA8EE),
            //   onTap: () => _onLanguageSelected(
            //     context,
            //   ),
            // ), // TODO: Implement language selection
            _AccountListTile(
              title: "theme".tr().toCapitalized(),
              iconData: FontAwesomeIcons.moonStars,
              iconColor: const Color(0xFFFFB9AA),
              onTap: () => _onThemeSelected(
                context,
              ),
            ),
            const Divider(),
            _AccountSwitchListTile(
              title: "biometricRegistration".tr().toCapitalized(),
              iconData: FontAwesomeIcons.fingerprint,
              iconColor: const Color(0xFFAB92F0),
              initialValue: false,
              onChanged: (value) => _onBiometricSelected(context, value),
            ),
            // _AccountListTile(
            //   title: "passwordChange".tr().toCapitalized(),
            //   iconData: FontAwesomeIcons.lock,
            //   iconColor: Colors.pink,
            //   onTap: () => context.router.push(const PasswordChangeRoute()),
            // ),
            _AccountListTile(
              title: "securityInformation".tr().toCapitalized(),
              iconData: FontAwesomeIcons.shield,
              iconColor: const Color(0xFFFB923C),
              onTap: () => _onSecuritySelected(context),
            ),
            const Divider(),
            _AccountListTile(
              title: "UNE",
              iconData: FontAwesomeIcons.userHeadset,
              iconColor: Colors.blueAccent,
              onTap: () => context.router.push(const UneRoute()),
            ),
            const Divider(
              height: 30,
            ),
            const LastLoginText(),
          ],
        ),
      );

  Future _onRefresh(BuildContext context) => Future.wait(
        [
          context.read<LastLoginLoadCubit>().getInfo(),
          context.read<ProcurementDataLoadCubit>().getInfo(),
        ],
      );

  void _onInfoSelected(BuildContext context) => context.router.push(
        const AccountInfoRoute(),
      );

  Future _onLanguageSelected(BuildContext context) => context.router.push(
        const SelectLanguajeRoute(),
      );

  Future _onThemeSelected(BuildContext context) => context.router.push(
        const SelectThemeRoute(),
      );

  Future _onSecuritySelected(BuildContext context) async => context.router.push(
        const SecurityInformationRoute(),
      );

  Future<bool> _onBiometricSelected(BuildContext context, bool value) async =>
      showBiometricsOverlay(
        context: context,
        toggle: value,
      );
}
