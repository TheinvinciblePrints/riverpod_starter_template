import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/providers/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/application/auth_service.dart';
import '../features/onboarding/application/onboarding_logic.dart';
import '../features/onboarding/data/onboarding_repository.dart';
import '../network/network.dart';
import 'startup_state.dart';

part 'startup_notifier.g.dart';

@Riverpod(keepAlive: true)
class StartupNotifier extends _$StartupNotifier {
  @override
  StartupState build() {
    // Initialize with loading state first, then handle startup logic
    // This prevents "uninitialized provider" errors
    Future.microtask(() => _handleStartupLogic());
    return const StartupState.loading();
  }

  Future<void> _handleStartupLogic({
    void Function(bool)? setRetryLoading,
  }) async {
    final logger = ref.read(loggerProvider);
    setRetryLoading?.call(true);
    try {
      // No need to check state here as we're already initialized in loading state
      // and using Future.microtask ensures this runs after build() completes

      final didCompleteOnboarding = await ref.read(
        isOnboardingCompleteProvider.future,
      );

      await Future.delayed(const Duration(seconds: 2));

      try {
        final authService = await ref.read(authServiceProvider.future);
        final userResult = await authService.getCurrentUser();

        state = switch (userResult) {
          Success(data: final user) =>
            (() {
              logger.i(
                'Startup completed: onboarding=$didCompleteOnboarding, user=${user.username}',
              );
              return StartupState.completed(
                didCompleteOnboarding: didCompleteOnboarding,
                isLoggedIn: true,
              );
            })(),
          Error(error: final error) =>
            (() {
              logger.w('Startup error: $error');
              if (error is UnauthorisedRequestNetworkFailure) {
                return StartupState.completed(
                  didCompleteOnboarding: didCompleteOnboarding,
                  isLoggedIn: false,
                );
              }
              return StartupState.error(error.message, error);
            })(),
        };
      } catch (e, st) {
        logger.w(
          'Auth error, continuing unauthenticated',
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

      // On critical failures, we'll still set to a safe state to avoid infinite loading
      // Setting to error state allows the user to retry, or the app to fall back to a safe state
      state = StartupState.error(e.toString(), e);

      // If this is happening during build(), we need to make sure we don't throw
      // an exception that would crash the app
    } finally {
      setRetryLoading?.call(false);
    }
  }

  void retry({void Function(bool)? setRetryLoading}) {
    // Don't emit loading state during retry to avoid showing the loading widget
    // The retry button will show its own loading indicator
    _handleStartupLogic(setRetryLoading: setRetryLoading);
  }

  void completeOnboardingAndSetUnauthenticated() {
    final logger = ref.read(loggerProvider);
    logger.i('Onboarding completed; not logged in');
    state = const StartupState.completed(
      didCompleteOnboarding: true,
      isLoggedIn: false,
    );
  }

  void updateLoginState(bool isLoggedIn) {
    final logger = ref.read(loggerProvider);
    logger.i('Login state updated: isLoggedIn=$isLoggedIn');
    switch (state) {
      case StartupCompleted(:final didCompleteOnboarding):
        state = StartupState.completed(
          didCompleteOnboarding: didCompleteOnboarding,
          isLoggedIn: isLoggedIn,
        );
        break;
      case StartupUnauthenticated():
      case StartupLoading():
      case StartupError():
        state = StartupState.completed(
          didCompleteOnboarding: true,
          isLoggedIn: isLoggedIn,
        );
        break;
    }
  }

  void disposeStartupAndDependents(WidgetRef widgetRef) {
    final logger = ref.read(loggerProvider);
    if (state is! StartupLoading && state is! StartupError) {
      logger.i('Cleaning up startup dependencies');
      widgetRef.invalidate(onboardingRepositoryProvider);
    }
  }
}
