import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/authentication/data/auth_repository.dart';
import '../features/onboarding/data/onboarding_repository.dart';
import '../shared/base/base_state_notifier.dart';

class StartupState {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final bool didCompleteOnboarding;
  final bool isLoggedIn;

  const StartupState({
    this.isLoading = true,
    this.hasError = false,
    this.errorMessage,
    this.didCompleteOnboarding = false,
    this.isLoggedIn = false,
  });

  StartupState copyWith({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    bool? didCompleteOnboarding,
    bool? isLoggedIn,
  }) {
    return StartupState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      didCompleteOnboarding:
          didCompleteOnboarding ?? this.didCompleteOnboarding,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

class StartupNotifier extends BaseStateNotifier<StartupState> {
  StartupNotifier(Ref ref) : super(ref, const StartupState());

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
      state = state.copyWith(
        isLoading: false,
        hasError: false,
        didCompleteOnboarding: didCompleteOnboarding,
        isLoggedIn: isLoggedIn,
      );
      logger.info(
        'Startup completed: onboarding=$didCompleteOnboarding, loggedIn=$isLoggedIn',
      );
    } catch (e, st) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
      logger.severe('Startup failed', e, st);
    }
  }

  void retry() {
    state = state.copyWith(
      isLoading: true,
      hasError: false,
      errorMessage: null,
    );
    _handleStartUpLogic();
  }
}

final startupNotifierProvider =
    StateNotifierProvider<StartupNotifier, StartupState>(
      (ref) => StartupNotifier(ref),
    );
