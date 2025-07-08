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
    final path = state.uri.path;

    // 1. While loading, stay on splash
    if (isLoading) {
      return path == AppRoute.splash.path ? null : AppRoute.splash.path;
    }

    // 2. Handle splash redirects when loading is done
    if (path == AppRoute.splash.path) {
      if (!didCompleteOnboarding) return AppRoute.onboarding.path;
      if (!isLoggedIn) return AppRoute.login.path;
      return AppRoute.home.path;
    }

    // 3. If logged in, skip onboarding and login
    if (isLoggedIn) {
      if (path == AppRoute.login.path || path == AppRoute.onboarding.path) {
        return AppRoute.home.path;
      }
      return null; // allow other routes
    }

    // 4. If not logged in and onboarding not completed, force onboarding
    if (!didCompleteOnboarding && path != AppRoute.onboarding.path) {
      return AppRoute.onboarding.path;
    }

    // 5. If not logged in and accessing home → redirect to login
    if (!isLoggedIn && path == AppRoute.home.path) {
      return AppRoute.login.path;
    }

    // 6. Allow access to login or onboarding if not logged in
    return null;
  }
}

/// Provider that creates and manages the RouterNotifier
/// This provider needs to stay alive for the entire app lifecycle
@Riverpod(keepAlive: true)
Raw<RouterNotifier> routerNotifier(Ref ref) {
  return RouterNotifier(ref);
}
