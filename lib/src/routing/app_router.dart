import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/authentication.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/onboarding.dart';
import 'routing.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute { splash, onboarding, login, home }

extension AppRoutePath on AppRoute {
  String get path => '/$name';
}

/// Top go_router entry point with more explicit navigation control.
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final isLoggedIn = ref.watch(isLoggedInProvider);
  final didCompleteOnboarding = ref.watch(didCompleteOnboardingProvider);
  final isLoading = ref.watch(isLoadingProvider);

  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoute.splash.path,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      // Get the current path
      final path = state.uri.path;

      // Always show splash screen when loading
      if (isLoading) {
        // Only redirect to splash if not already there to avoid redirection loops
        return path == AppRoute.splash.path ? null : AppRoute.splash.path;
      }

      // After loading completes, handle redirection based on state
      // If onboarding is not complete, show onboarding
      if (!didCompleteOnboarding &&
          !path.startsWith(AppRoute.onboarding.path)) {
        return AppRoute.onboarding.path;
      }

      // If user is not logged in and trying to access protected routes
      if (!isLoggedIn && path.startsWith(AppRoute.home.path)) {
        return AppRoute.login.path;
      }

      // If user is logged in and trying to access login/onboarding
      if (isLoggedIn &&
          (path.startsWith(AppRoute.login.path) ||
              path.startsWith(AppRoute.onboarding.path))) {
        return AppRoute.home.path;
      }

      // Handle splash redirects when loading is complete
      if (path == AppRoute.splash.path) {
        if (!didCompleteOnboarding) return AppRoute.onboarding.path;
        if (!isLoggedIn) return AppRoute.login.path;
        return AppRoute.home.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (_, __) => const AppStartupWidget(),
      ),
      GoRoute(
        path: AppRoute.onboarding.path,
        name: AppRoute.onboarding.name,
        pageBuilder:
            (context, state) =>
                const NoTransitionPage(child: OnboardingScreen()),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder: (context, state) => NoTransitionPage(child: LoginScreen()),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        pageBuilder: (context, state) => NoTransitionPage(child: HomeScreen()),
      ),
    ],
  );
}

/// Provider for checking if the user is logged in
final isLoggedInProvider = Provider<bool>((ref) {
  final startup = ref.watch(startupNotifierProvider);
  return switch (startup) {
    StartupCompleted(isLoggedIn: final isLoggedIn) => isLoggedIn,
    _ => false,
  };
});

/// Provider to check if onboarding is completed
final didCompleteOnboardingProvider = Provider<bool>((ref) {
  final startup = ref.watch(startupNotifierProvider);
  return switch (startup) {
    StartupCompleted(didCompleteOnboarding: final completed) => completed,
    StartupLoading() => false, // Default to false while loading
    StartupError() => false, // Default to false on error
    StartupUnauthenticated() =>
      true, // If unauthenticated, onboarding is complete
  };
});

/// Checks if the app is still in startup loading state
final isLoadingProvider = Provider<bool>((ref) {
  final startup = ref.watch(startupNotifierProvider);
  // Consider both loading and error states to prevent immediate redirection
  return startup is StartupLoading || startup is StartupError;
});
