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

  void disposeStartupAndDependents(WidgetRef ref) {
    ref.invalidate(startupNotifierProvider);
    ref.invalidate(onboardingRepositoryProvider);
    ref.invalidate(authServiceProvider);
    // Add any other dependent providers here if needed
  }
}

final startupNotifierProvider =
    StateNotifierProvider<StartupNotifier, StartupState>(
      (ref) => StartupNotifier(ref),
    );
