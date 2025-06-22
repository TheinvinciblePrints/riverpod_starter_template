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

/// Top go_router entry point.
///
/// Listens to changes in [AuthRepository] to redirect the user
/// to /login when the user logs out.
@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: AppRoute.splash.path,
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) => _handleRedirection(context, state, ref),
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
        pageBuilder:
            (context, state) => const NoTransitionPage(child: LoginScreen()),
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (_, __) => const HomeScreen(),
      ),
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
) {
  final startup = ref.watch(startupNotifierProvider);
  final path = state.uri.path;

  switch (startup) {
    case StartupLoading():
      return AppRoute.splash.path;
    case StartupError():
      return AppRoute.splash.path;
    case StartupUnauthenticated():
      return path == AppRoute.login.path ? null : AppRoute.login.path;
    case StartupCompleted(
      didCompleteOnboarding: final didCompleteOnboarding,
      isLoggedIn: final isLoggedIn,
    ):
      // If onboarding not complete, redirect to onboarding
      if (!didCompleteOnboarding && path != AppRoute.onboarding.path) {
        return AppRoute.onboarding.path;
      }
      // If not logged in and trying to access home, redirect to login
      if (!isLoggedIn && path.startsWith(AppRoute.home.path)) {
        return AppRoute.login.path;
      }
      // If logged in and trying to access login/onboarding/splash, redirect to home
      if (isLoggedIn &&
          (path == AppRoute.login.path ||
              path == AppRoute.onboarding.path ||
              path == AppRoute.splash.path)) {
        return AppRoute.home.path;
      }
      // If on splash, route to correct place
      if (path == AppRoute.splash.path) {
        if (!didCompleteOnboarding) return AppRoute.onboarding.path;
        if (!isLoggedIn) return AppRoute.login.path;
        return AppRoute.home.path;
      }
      return null;
  }
}
