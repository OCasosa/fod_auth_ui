import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_common_classes/flutter_common_classes.dart";
import "package:fod_auth_ui/fod_auth_ui.dart";

import "../cubits/splash_screen_cubit.dart";

/// The splash screen page.
///
/// This page is the first page that the user sees when they open the app.
/// It shows a splash animation and then navigates to the [UsernameRegisterPage]
@RoutePage()
class SplashPage extends StatelessWidget {
  /// The splash screen page.
  ///
  /// This page is the first page that the user sees when they open the app.
  /// It shows a splash animation and then navigates
  /// to the [UsernameRegisterPage]
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SplashScreenCubit>(
                create: (_) => SplashScreenCubit(),
              ),
            ],
            child: const _SplashScreenContent(),
          ),
        ),
      );
}

class _SplashScreenContent extends StatefulWidget {
  const _SplashScreenContent();

  @override
  State<_SplashScreenContent> createState() => _SplashScreenContentState();
}

class _SplashScreenContentState extends State<_SplashScreenContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
          if (state is SplashScreenSuccess) {
            _onPageExit();
          }
        },
        builder: (context, state) => switch (state.status) {
          SplashScreenStatus.loading => const Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          SplashScreenStatus.animationFinished => const Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          SplashScreenStatus.success => const CircularProgressIndicator(),
          SplashScreenStatus.newVersionAvailable =>
            const CircularProgressIndicator(),
          SplashScreenStatus.failure => Text(
              state.failure!.message,
              style: context.textTheme.headlineLarge?.copyWith(),
            ),
        },
      );

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _controller
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.read<SplashScreenCubit>().markAnimationFinished();
        }
      });
  }

  void _onPageExit() {
    _moveToAuthPage();
  }

  void _moveToAuthPage() => FodAuthUi.goToAuth(
        context: context,
        step: context.read<SplashScreenCubit>().authStep,
      );
}
