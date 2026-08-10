part of "splash_screen_cubit.dart";

/// State for the splash screen cubit.
class SplashScreenState extends Equatable {
  /// Constructor for the state.
  const SplashScreenState({
    required this.status,
    this.failure,
    this.isUserFirstTime = false,
  });

  /// The failure that occurred.
  final Failure? failure;

  /// True if is the first time the user opens the app
  final bool isUserFirstTime;

  /// The status of the splash screen.
  final SplashScreenStatus status;

  @override
  List<Object?> get props => [
        failure,
        status,
      ];
}

/// State for when the splash screen is loading.
class SplashScreenLoading extends SplashScreenState {
  /// State for when the splash screen is loading.
  const SplashScreenLoading()
      : super(
          status: SplashScreenStatus.loading,
        );
}

/// State for when the splash screen animation has finished.
class SplashScreenAnimationFinished extends SplashScreenState {
  /// State for when the splash screen animation has finished.
  const SplashScreenAnimationFinished()
      : super(
          status: SplashScreenStatus.animationFinished,
        );
}

/// State for when the splash screen has successfully loaded.
class SplashScreenSuccess extends SplashScreenState {
  /// State for when the splash screen has successfully loaded.
  const SplashScreenSuccess({
    required super.isUserFirstTime,
  }) : super(
          status: SplashScreenStatus.success,
        );
}

/// State for when the splash screen has failed to load.
class SplashScreenFailure extends SplashScreenState {
  /// State for when the splash screen has failed to load.
  const SplashScreenFailure({
    required Failure failure,
  }) : super(
          status: SplashScreenStatus.failure,
          failure: failure,
        );
}

/// Enum for the status of the splash screen.
enum SplashScreenStatus {
  /// The splash screen is loading.
  loading,

  /// The splash screen animation has finished.
  animationFinished,

  /// There is a new version available.
  newVersionAvailable,

  /// The splash screen has successfully loaded.
  success,

  /// The splash screen has failed to load.
  failure,
}
