import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routing.dart';
import 'startup_notifier.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(startupNotifierProvider);
    final notifier = ref.read(startupNotifierProvider.notifier);

    if (startup.isLoading) {
      return const AppStartupLoadingWidget();
    }
    if (startup.hasError) {
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
