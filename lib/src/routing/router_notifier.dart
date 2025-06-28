import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_router.dart';

part 'router_notifier.g.dart';

/// A notifier that handles routing logic based on authentication and startup state.
/// This approach centralizes routing decisions and allows for more granular control
/// over redirections.
class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    // Listen to auth changes
    _ref.listen(isLoggedInProvider, (_, __) => notifyListeners());
    _ref.listen(didCompleteOnboardingProvider, (_, __) => notifyListeners());
    _ref.listen(isLoadingProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;

  /// Determines where to redirect the user based on current auth state
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final isLoading = _ref.read(isLoadingProvider);
    final isLoggedIn = _ref.read(isLoggedInProvider);
    final didCompleteOnboarding = _ref.read(didCompleteOnboardingProvider);

    // Get the current path
    final path = state.uri.path;

    // Always show splash screen when loading
    if (isLoading) {
      // Only redirect to splash if not already there to avoid redirection loops
      return path == AppRoute.splash.path ? null : AppRoute.splash.path;
    }

    // After loading completes, handle redirection based on state
    // If onboarding is not complete, show onboarding
    if (!didCompleteOnboarding && !path.startsWith(AppRoute.onboarding.path)) {
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
  }
}

/// Provider that creates and manages the RouterNotifier
/// This provider needs to stay alive for the entire app lifecycle
@Riverpod(keepAlive: true)
Raw<RouterNotifier> routerNotifier(Ref ref) {
  return RouterNotifier(ref);
}
