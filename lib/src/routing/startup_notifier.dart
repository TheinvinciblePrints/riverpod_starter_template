import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentication/data/auth_repository.dart';
import '../features/onboarding/data/onboarding_repository.dart';
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
      // Simulate splash delay for UX/testing
      await Future.delayed(const Duration(seconds: 2));

      // Onboarding
      final onboardingRepo = await ref.read(
        onboardingRepositoryProvider.future,
      );
      final didCompleteOnboarding = onboardingRepo.isOnboardingComplete();
      // Auth
      final authRepo = await ref.read(authRepositoryProvider.future);
      final isLoggedIn = await authRepo.getCurrentUser() != null;

      state = StartupState.completed(
        didCompleteOnboarding: didCompleteOnboarding,
        isLoggedIn: isLoggedIn,
      );
      logger.i(
        'Startup completed: onboarding=$didCompleteOnboarding, loggedIn=$isLoggedIn',
      );
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
    state = const StartupState.unauthenticated();
  }
}

final startupNotifierProvider =
    StateNotifierProvider<StartupNotifier, StartupState>(
      (ref) => StartupNotifier(ref),
    );
