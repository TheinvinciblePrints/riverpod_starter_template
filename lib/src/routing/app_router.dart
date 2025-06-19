import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/authentication.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/onboarding/onboarding.dart';
import 'routing.dart';
import 'startup_notifier.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Top go_router entry point.
///
/// Listens to changes in [AuthTokenRepository] to redirect the user
/// to /login when the user logs out.
@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: Routes.home,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) => _handleRedirection(context, state, ref),
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const AppStartupWidget(),
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
) {
  final startup = ref.watch(startupNotifierProvider);
  final path = state.uri.path;

  if ((startup.isLoading ?? false) || (startup.hasError ?? false)) {
    return Routes.splash;
  }
  if (!(startup.didCompleteOnboarding ?? false) && path != Routes.onboarding) {
    return Routes.onboarding;
  }
  if (!(startup.isLoggedIn ?? false) && path.startsWith(Routes.home)) {
    return Routes.login;
  }
  if ((startup.isLoggedIn ?? false) &&
      (path == Routes.login ||
          path == Routes.onboarding ||
          path == Routes.splash)) {
    return Routes.home;
  }
  if (path == Routes.splash) {
    if (!(startup.didCompleteOnboarding ?? false)) return Routes.onboarding;
    if (!(startup.isLoggedIn ?? false)) return Routes.login;
    return Routes.home;
  }
  return null;
}
