import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_error_handler.dart';
import 'package:flutter_riverpod_starter_template/src/shared/shared.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';
import 'package:flutter_riverpod_starter_template/src/utils/network_exception_utils.dart';

import '../gen/assets.gen.dart';
import '../localization/locale_keys.g.dart';
import '../network/network_exceptions.dart';
import '../network/network_failures.dart';
import 'routing.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startup = ref.watch(startupNotifierProvider);
    final notifier = ref.read(startupNotifierProvider.notifier);

    return switch (startup) {
      StartupLoading() => const AppStartupLoadingWidget(),
      StartupError(message: final message, errorObject: final error) =>
        AppStartupErrorWidget(
          message: message ?? 'Unknown error',
          error: error,
          onRetry: () => notifier.retry(),
        ),
      StartupUnauthenticated() =>
        const SizedBox.shrink(), // Let router handle navigation
      StartupCompleted(didCompleteOnboarding: final _, isLoggedIn: final _) =>
        const SizedBox.shrink(),
    };
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
class AppStartupErrorWidget extends StatelessWidget with NetworkErrorHandler {
  const AppStartupErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.error,
  });
  final String message;
  final VoidCallback onRetry;
  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr(LocaleKeys.error),
          style: context.textTheme.linkMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAssets.lottie.errorLottie.lottie(),
            Text(
              context.tr(_getDisplayTitleMessage(), args: [message]),
              textAlign: TextAlign.center,
              style: context.textTheme.appStartUpErrorTitle,
            ),
            Text(
              context.tr(_getDisplayMessage(), args: [message]),
              textAlign: TextAlign.center,
              style: context.textTheme.appStartUpErrorSubTitle,
            ),
            Gap(50),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: PrimaryButton(label: LocaleKeys.retry, onPressed: onRetry),
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayMessage() {
    if (error is NetworkExceptions) {
      final key = NetworkExceptionUtils.getErrorMessage(error as NetworkExceptions);
      return key;
    }
    return message;
  }

  String _getDisplayTitleMessage() {
    if (error is NetworkExceptions) {
      final networkFailure = mapNetworkExceptionToNetworkFailure(
        error as NetworkExceptions,
      );
      if (networkFailure is NoInternetConnectionNetworkFailure) {
        return LocaleKeys.noInternetConnectionTitle.tr();
      } else {
        return networkFailure.message;
      }
    }
    return LocaleKeys.error;
  }
}
