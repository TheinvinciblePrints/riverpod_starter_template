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
  // Use the RouterNotifier to handle navigation logic and state changes
  final notifier = ref.watch(routerNotifierProvider);

  return GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: AppRoute.splash.path,
    navigatorKey: _rootNavigatorKey,
    // Pass the RouterNotifier as a refresh listenable to react to auth changes
    refreshListenable: notifier,
    // Use the RouterNotifier's redirect logic
    redirect: notifier.redirectLogic,
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

@riverpod
bool isLoggedIn(Ref ref) {
  final startup = ref.watch(startupNotifierProvider);
  return switch (startup) {
    StartupCompleted(isLoggedIn: final isLoggedIn) => isLoggedIn,
    _ => false,
  };
}

@riverpod
bool didCompleteOnboarding(Ref ref) {
  final startup = ref.watch(startupNotifierProvider);
  return switch (startup) {
    StartupCompleted(didCompleteOnboarding: final completed) => completed,
    StartupLoading() => false,
    StartupError() => false,
    StartupUnauthenticated() => true,
  };
}

@riverpod
bool isLoading(Ref ref) {
  final startup = ref.watch(startupNotifierProvider);
  return startup is StartupLoading || startup is StartupError;
}
