import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/authentication.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/onboarding.dart';
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
    initialLocation: Routes.login,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) => _handleRedirection(context, state, ref),
    routes: [
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
  // Watch the onboarding repository (AsyncValue)
  final onboarding = ref.watch(onboardingRepositoryProvider);

  // ⏳ If onboarding is still loading or errored, don't redirect yet
  if (onboarding is AsyncLoading || onboarding is AsyncError) return null;

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
    if (path == Routes.login || path == Routes.onboarding) {
      return Routes.home;
    }
  } else {
    // If NOT logged in and trying to access protected routes, redirect to login
    if (path.startsWith(Routes.home)) {
      return Routes.login;
    }
  }

  // No redirection needed — allow navigation to proceed
  return null;
}
