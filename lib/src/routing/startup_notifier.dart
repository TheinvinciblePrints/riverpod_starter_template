import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentication/application/auth_service.dart';
import '../features/onboarding/data/onboarding_repository.dart';
import '../network/network.dart';
import '../shared/base/base_state_notifier.dart';
import 'startup_state.dart';

class StartupNotifier extends BaseStateNotifier<StartupState> {
  StartupNotifier(Ref ref) : super(ref, const StartupState.loading());

  @override
  void onInit() {
    _handleStartUpLogic();
  }

  Future<void> _handleStartUpLogic() async {
    try {
      // Make sure we're in loading state
      if (state is! StartupLoading) {
        state = const StartupState.loading();
      }

      // First get onboarding status since it's synchronous after the repo is available
      final onboardingRepo = await ref.read(
        onboardingRepositoryProvider.future,
      );
      final didCompleteOnboarding = onboardingRepo.isOnboardingComplete();

      // Keep the app in loading state for at least 2 seconds for better UX
      await Future.delayed(const Duration(seconds: 2));

      try {
        // Auth service has a 5-second delay
        final authService = await ref.read(authServiceProvider.future);
        final userResult = await authService.getCurrentUser();

        state = switch (userResult) {
          Success(data: final user) =>
            (() {
              logger.i(
                'Startup completed successfully: onboarding=$didCompleteOnboarding, user=${user.username}',
              );
              return StartupState.completed(
                didCompleteOnboarding: didCompleteOnboarding,
                isLoggedIn: true,
              );
            })(),
          Error(error: final error) =>
            (() {
              logger.w('Startup completed with error: $error', error: error);
              if (error is UnauthorisedRequestNetworkFailure) {
                // If unauthorised, we assume the user is not logged in
                return StartupState.completed(
                  didCompleteOnboarding: didCompleteOnboarding,
                  isLoggedIn: false,
                );
              }
              return StartupState.error(userResult.error.message, error);
            })(),
        };
      } catch (e, st) {
        // If auth service fails, we'll complete startup but mark as not logged in
        logger.w(
          'Auth service error, continuing with unauthenticated state',
          error: e,
          stackTrace: st,
        );
        state = StartupState.completed(
          didCompleteOnboarding: didCompleteOnboarding,
          isLoggedIn: false,
        );
      }
    } catch (e, st) {
      logger.f('Startup failed', error: e, stackTrace: st);
      state = StartupState.error(e.toString(), e);
    }
  }

  void retry() {
    state = const StartupState.loading();
    _handleStartUpLogic();
  }

  void completeOnboardingAndSetUnauthenticated() {
    logger.i(
      'Setting state to completed with onboarding=true after onboarding completion',
    );

    // Instead of just setting to unauthenticated, set to completed with onboarding=true
    // This is more precise than using the unauthenticated state and helps with routing logic
    state = const StartupState.completed(
      didCompleteOnboarding: true,
      isLoggedIn: false,
    );
  }

  /// Updates the login state in the startup state
  /// This is called after a successful login to trigger the router's redirection
  void updateLoginState(bool isLoggedIn) {
    logger.i('Updating login state: isLoggedIn=$isLoggedIn');

    // Make sure to run this update synchronously to avoid race conditions
    // with the router redirection

    // Handle different state types
    switch (state) {
      case StartupCompleted(:final didCompleteOnboarding):
        // If already in completed state, just update login status
        state = StartupState.completed(
          didCompleteOnboarding: didCompleteOnboarding,
          isLoggedIn: isLoggedIn,
        );
        break;

      case StartupUnauthenticated():
        // If in unauthenticated state, update to completed with login status
        state = StartupState.completed(
          didCompleteOnboarding: true,
          isLoggedIn: isLoggedIn,
        );
        break;

      case StartupLoading():
        // If still loading, wait until loading completes but force it to complete
        logger.w('Login state update while still loading, forcing completion');
        state = StartupState.completed(
          didCompleteOnboarding: true,
          isLoggedIn: isLoggedIn,
        );
        break;

      case StartupError():
        // If in error state, transition to completed state
        logger.i('Transitioning from error state to logged in state');
        state = StartupState.completed(
          didCompleteOnboarding: true, // Assume onboarding is complete
          isLoggedIn: isLoggedIn,
        );
        break;
    }
  }

  /// Manually invalidates startup-related providers when they're no longer needed
  /// This prevents unnecessary provider disposal warnings and memory leaks
  void disposeStartupAndDependents(WidgetRef ref) {
    // Only invalidate if we're done with startup and navigation has completed
    if (state is! StartupLoading && state is! StartupError) {
      logger.i('Cleaning up startup providers');
      // Don't invalidate startupNotifierProvider itself as it's needed for routing
      ref.invalidate(onboardingRepositoryProvider);

      // We don't want to invalidate authRepositoryProvider or authServiceProvider
      // as they are needed for the login screen

      // Invalidate any other startup-specific providers here
    }
  }
}

final startupNotifierProvider =
    StateNotifierProvider<StartupNotifier, StartupState>((ref) {
      // Keep the provider alive during the entire app session
      ref.keepAlive();
      return StartupNotifier(ref);
    });
