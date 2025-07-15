import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/providers/logger_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/application/auth_service.dart';
import '../features/countries/data/countries_repository.dart';
import '../features/countries/domain/country.dart';
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

      await Future.delayed(const Duration(seconds: 2));
      // Use Future.wait with error-wrapped futures for parallel loading
      // This allows us to handle failures gracefully for non-critical operations
      final results = await Future.wait([
        // Critical: Must succeed or app can't proceed
        ref.read(isOnboardingCompleteProvider.future),
        // Optional: Wrap in error handling so failure doesn't break startup
        _loadCountriesWithErrorHandling(),
        // Important: Wrap in error handling with fallback to unauthenticated
        _loadAuthWithErrorHandling(),
      ]);

      final didCompleteOnboarding = results[0] as bool;
      final countriesResult = results[1] as ApiResult<List<Country>>?;
      final authResult = results[2] as ApiResult<dynamic>?;

      // Log countries result
      switch (countriesResult) {
        case Success(data: final countries):
          logger.i(
            '🌍 [STARTUP] Countries loaded successfully: ${countries.length} countries',
          );
        case Error(error: final error):
          logger.w('🌍 [STARTUP] Countries loading failed: $error');
        case null:
          logger.w('🌍 [STARTUP] Countries loading failed with null result');
      }

      // Handle auth result
      state = switch (authResult) {
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
            logger.w('Startup auth error: $error');
            if (error is UnauthorisedRequestNetworkFailure) {
              return StartupState.completed(
                didCompleteOnboarding: didCompleteOnboarding,
                isLoggedIn: false,
              );
            }
            return StartupState.error(error.message, error);
          })(),
        null =>
          (() {
            logger.w('Auth failed, continuing unauthenticated');
            return StartupState.completed(
              didCompleteOnboarding: didCompleteOnboarding,
              isLoggedIn: false,
            );
          })(),
      };
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

  /// Load countries with error handling - returns null if failed
  Future<ApiResult<List<Country>>?> _loadCountriesWithErrorHandling() async {
    try {
      final countriesRepo = await ref.read(countriesRepositoryProvider.future);
      return await countriesRepo.getCountries();
    } catch (e, st) {
      final logger = ref.read(loggerProvider);
      logger.w(
        '🌍 [STARTUP] Countries service error',
        error: e,
        stackTrace: st,
      );
      return ApiResult.error(
        error: CustomNetworkFailure(message: 'Failed to load countries: $e'),
      );
    }
  }

  /// Load auth state with error handling - returns null if failed
  Future<ApiResult<dynamic>?> _loadAuthWithErrorHandling() async {
    try {
      final authService = await ref.read(authServiceProvider.future);
      return await authService.getCurrentUser();
    } catch (e, st) {
      final logger = ref.read(loggerProvider);
      logger.w('🔐 [STARTUP] Auth service error', error: e, stackTrace: st);
      return ApiResult.error(
        error: CustomNetworkFailure(message: 'Failed to load auth: $e'),
      );
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
