import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/shared/shared.dart';

import '../gen/assets.gen.dart';
import '../localization/locale_keys.g.dart';
import '../network/network_exception.dart';
import 'startup_notifier.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(startupNotifierProvider);
    final notifier = ref.read(startupNotifierProvider.notifier);

    if (startup.isLoading ?? false) {
      return const AppStartupLoadingWidget();
    }
    if (startup.hasError ?? false) {
      return AppStartupErrorWidget(
        message: startup.errorMessage ?? 'Unknown error',
        error: startup.errorObject,
        onRetry: () => notifier.retry(),
      );
    }
    // Should never reach here, as GoRouter will redirect away when ready
    return const SizedBox.shrink();
  }
}

/// Widget to show while initialization is in progress
class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
    if (message.toLowerCase().contains('no internet')) {
      return LocaleKeys.noInternetConnection.tr();
    }
    return message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _getDisplayMessage(context),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Gap(16),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
