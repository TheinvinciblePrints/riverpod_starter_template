import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_error_handler.dart';
import 'package:flutter_riverpod_starter_template/src/shared/shared.dart';
import 'package:flutter_riverpod_starter_template/src/themes/themes.dart';
import 'package:flutter_riverpod_starter_template/src/utils/extensions/context_extensions.dart';
import 'package:flutter_riverpod_starter_template/src/utils/network_exception_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../gen/assets.gen.dart';
import '../localization/locale_keys.g.dart';
import '../network/network_exceptions.dart';
import '../network/network_failures.dart';
import 'routing.dart';

part 'app_startup.g.dart';

@riverpod
class RetryLoading extends _$RetryLoading {
  @override
  bool build() => false;

  void setLoading(bool loading) {
    state = loading;
  }
}

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
          onRetry:
              () => notifier.retry(
                setRetryLoading:
                    ref.read(retryLoadingProvider.notifier).setLoading,
              ),
        ),
      StartupUnauthenticated() =>
        const SizedBox.shrink(), // Let router handle navigation
      StartupCompleted() => const SizedBox.shrink(),
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
class AppStartupErrorWidget extends ConsumerWidget with NetworkErrorHandler {
  const AppStartupErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
    this.error,
  });
  final String message;
  final VoidCallback onRetry;
  final Object? error;

  void _handleRetry(WidgetRef ref) {
    if (ref.read(retryLoadingProvider)) return;
    onRetry();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRetrying = ref.watch(retryLoadingProvider);

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
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      isRetrying ? Colors.grey : AppColors.primary,
                    ),
                    foregroundColor: WidgetStateProperty.all(AppColors.primary),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 18),
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: isRetrying ? null : () => _handleRetry(ref),
                  child:
                      isRetrying
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : Text(
                            context.tr(LocaleKeys.retry),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayMessage() {
    if (error is NetworkExceptions) {
      final key = NetworkExceptionUtils.getErrorMessage(
        error as NetworkExceptions,
      );
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
