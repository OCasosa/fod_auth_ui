// ignore_for_file: avoid-dynamic

import "package:confirm_alert/localization/l10n.dart";
import "package:easy_localization/easy_localization.dart";
import "package:fintech_on_demand_onboarding_flutter/core/localization/l10n.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_common_classes/localization/l10n.dart";
import "package:flutter_flavor/flutter_flavor.dart";
import "package:fod_auth_flutter/fod_auth.dart";
import "package:form_builder_validators/localization/l10n.dart";
import "package:loader_overlay/loader_overlay.dart";

import "core/constants/theme/material_theme.dart";
import "core/routes/app_router.dart";
import "features/preferences/presentation/cubits/cubit_helper_selection_radi.dart";

final _appRouter = AppRouter();

/// [OneWalletBusinessApp] is the entry point of the application.
class OneWalletBusinessApp extends StatelessWidget {
  /// [OneWalletBusinessApp] is the entry point of the application.
  const OneWalletBusinessApp({
    required this.appName,
    this.builder,
    super.key,
  });

  /// The name of the application.
  final String appName;

  /// The builder function to build the application.
  final Widget Function(BuildContext, Widget?)? builder;

  @override
  Widget build(BuildContext context) => FlavorBanner(
        child: BlocProvider(
          create: (_) => CubitHelperSelectionRadi(),
          child: BlocBuilder<CubitHelperSelectionRadi, ThemeMode>(
            builder: (context, themeValue) => MaterialApp.router(
              title: appName,
              debugShowCheckedModeBanner: false,

              //Theming
              themeMode: themeValue,
              theme: MaterialTheme.light,
              darkTheme: MaterialTheme.dark,

              /// Localization
              localizationsDelegates: [
                ...context.localizationDelegates,
                FormBuilderLocalizations.delegate,
                OnboardingLocalizations.delegate,
                FlutterCommonLocalizations.delegate,
                FodAuthLocalizations.delegate,
                ConfirmAlertLocalizations.delegate,
              ],
              supportedLocales: context.supportedLocales,
              locale: const Locale("es"),

              builder: builder ??
                  (context, child) => LoaderOverlay(
                        child: child!,
                      ),

              routerConfig: _appRouter.config(),
            ),
          ),
        ),
      );
}
