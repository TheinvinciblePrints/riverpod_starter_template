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
      // Simulate splash delay for UX/testing (this can be removed if your apis is not fast)
      await Future.delayed(const Duration(seconds: 2));

      // Onboarding
      final onboardingRepo = await ref.read(
        onboardingRepositoryProvider.future,
      );
      final didCompleteOnboarding = onboardingRepo.isOnboardingComplete();

      // Auth - use the authService instead of directly accessing repository (this is why we have the application layer)
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
      state = StartupState.error(e.toString(), e);
      logger.f('Startup failed', error: e, stackTrace: st);
    }
  }

  void retry() {
    state = const StartupState.loading();
    _handleStartUpLogic();
  }

  void completeOnboardingAndSetUnauthenticated() {
    logger.i('Setting state to unauthenticated after onboarding completion');
    state = const StartupState.unauthenticated();
  }

  /// Updates the login state in the startup state
  /// This is called after a successful login to trigger the router's redirection
  void updateLoginState(bool isLoggedIn) {
    logger.i('Updating login state: isLoggedIn=$isLoggedIn');

    // Handle different state types
    switch (state) {
      case StartupCompleted(:final didCompleteOnboarding):
        // If already in completed state, just update login status
        state = StartupState.completed(
          didCompleteOnboarding: didCompleteOnboarding,
          isLoggedIn: isLoggedIn,
        );

      case StartupUnauthenticated():
        // If in unauthenticated state, update to completed with login status
        state = StartupState.completed(
          didCompleteOnboarding: true,
          isLoggedIn: isLoggedIn,
        );

      case StartupLoading():
        // If still loading, wait until loading completes
        logger.w('Cannot update login state: app is still in loading state');

      case StartupError():
        // If in error state, transition to completed state
        logger.i('Transitioning from error state to logged in state');
        state = StartupState.completed(
          didCompleteOnboarding: true, // Assume onboarding is complete
          isLoggedIn: isLoggedIn,
        );
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
