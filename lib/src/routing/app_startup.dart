import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/authentication.dart';
import '../features/onboarding/onboarding.dart';
import '../gen/assets.gen.dart';
import '../localization/locale_keys.g.dart';
import '../network/connection_checker.dart';
import '../network/network_exception.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  ref.onDispose(() {
    // ensure dependent providers are disposed as well
    ref.invalidate(onboardingRepositoryProvider);
  });

  // Check for internet connection before proceeding
  final connectionChecker = ref.watch(connectionCheckerProvider);
  if (await connectionChecker.isConnected() == NetworkStatus.offline) {
    throw NetworkExceptions.noInternetConnection();
  }

  // Wait for onboarding repository
  await ref.watch(onboardingRepositoryProvider.future);

  // Wait for authentication repository and check user (this will also throw if no internet)
  final authRepository = await ref.watch(authRepositoryProvider.future);
  await authRepository.getCurrentUser();
}

/// Widget class to manage asynchronous app initialization
class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final WidgetBuilder onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (_) => onLoaded(context),
      loading: () => const AppStartupLoadingWidget(),
      error:
          (e, st) => AppStartupErrorWidget(
            message: e.toString(),
            onRetry: () => ref.invalidate(appStartupProvider),
            error: e,
          ),
    );
  }
}

/// Widget to show while initialization is in progress
class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppAssets.images.appLogo.image(height: 66, width: 217),
      ),
    );
  }
}

/// Widget to show if initialization fails
class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.error,
  });
  final String message;
  final VoidCallback onRetry;
  final Object? error;

  String _getDisplayMessage(BuildContext context) {
    if (error is NetworkExceptions) {
      final key = NetworkExceptions.getErrorMessage(error as NetworkExceptions);
      return key.tr();
    }
    // fallback: try to match known error strings
    if (message.toLowerCase().contains('no internet')) {
      return LocaleKeys.noInternetConnection.tr();
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getDisplayMessage(context),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Gap(24),
                ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
