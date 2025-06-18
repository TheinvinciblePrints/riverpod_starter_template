import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/authentication.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/onboarding.dart';
import 'app_startup.dart';
import 'routes.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user
/// to /login when the user logs out.
@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) => _handleRedirection(context, state, ref),
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const AppStartupLoadingWidget(),
      ),
      GoRoute(
        path: Routes.onboarding,
        builder: (_, __) => const OnboardingScreen(),
      ),
      GoRoute(path: Routes.login, builder: (_, __) => const LoginScreen()),
      GoRoute(path: Routes.home, builder: (_, __) => const HomeScreen()),
    ],
  );
}

/// Handles redirection logic for GoRouter based on onboarding status and auth state.
///
/// This method determines where the user should be redirected:
/// - Redirects to onboarding if onboarding is incomplete.
/// - Redirects to login if not authenticated.
/// - Redirects to home if already authenticated but tries to access login/onboarding.
FutureOr<String?> _handleRedirection(
  BuildContext context,
  GoRouterState state,
  Ref ref,
) async {
  // Wait for app startup to complete before any routing
  final appStartup = ref.watch(appStartupProvider);
  if (appStartup is AsyncLoading || appStartup is AsyncError) {
    return Routes.splash;
  }

  // Watch the onboarding repository (AsyncValue)
  final onboarding = ref.watch(onboardingRepositoryProvider);

  // ⏳ If onboarding is still loading or errored, don't redirect yet
  if (onboarding is AsyncLoading || onboarding is AsyncError) {
    // Always show splash while loading or error
    return Routes.splash;
  }

  // Check if onboarding has been completed
  final didCompleteOnboarding =
      onboarding.value?.isOnboardingComplete() ?? false;

  // Current requested route path
  final path = state.uri.path;

  // Redirect to onboarding if not complete and not already on onboarding page
  if (!didCompleteOnboarding && path != Routes.onboarding) {
    return Routes.onboarding;
  }

  // Read the auth repository and check if user is logged in
  final authRepository = await ref.read(authRepositoryProvider.future);
  final isLoggedIn = await authRepository.getCurrentUser() != null;

  // If logged in and trying to access login or onboarding, redirect to home
  if (isLoggedIn) {
    if (path == Routes.login ||
        path == Routes.onboarding ||
        path == Routes.splash) {
      return Routes.home;
    }
  } else {
    // If NOT logged in and trying to access protected routes, redirect to login
    if (path.startsWith(Routes.home)) {
      return Routes.login;
    }
  }

  // If on splash and everything is ready, go to the right place
  if (path == Routes.splash) {
    if (!didCompleteOnboarding) return Routes.onboarding;
    if (!isLoggedIn) return Routes.login;
    return Routes.home;
  }

  // No redirection needed — allow navigation to proceed
  return null;
}
