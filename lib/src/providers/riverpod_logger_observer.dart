import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'logger_provider.dart';

/// A ProviderObserver that uses the loggerProvider to log provider lifecycle events
class RiverpodLoggerObserver extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    // Skip logging for the loggerProvider itself to avoid circular dependency
    if (provider.name == 'loggerProvider' || provider == loggerProvider) {
      return;
    }

    // Get the logger safely
    final logger = _getLoggerSafely(container);
    if (logger == null) return;

    logger.d(
      '📦 Provider added: ${provider.name ?? provider.runtimeType}\n'
      '  Value: $value',
    );
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // Skip logging for the loggerProvider itself to avoid circular dependency
    if (provider.name == 'loggerProvider' ||
        provider == loggerProvider ||
        previousValue == newValue) {
      return;
    }

    // Get the logger safely
    final logger = _getLoggerSafely(container);
    if (logger == null) return;

    logger.d(
      '♻️ Provider updated: ${provider.name ?? provider.runtimeType}\n'
      '  Old value: $previousValue\n'
      '  New value: $newValue',
    );
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    // Skip logging for the loggerProvider itself to avoid circular dependency
    if (provider.name == 'loggerProvider' || provider == loggerProvider) {
      return;
    }

    // Get the logger safely
    final logger = _getLoggerSafely(container);
    if (logger == null) return;

    logger.d('🗑️ Provider disposed: ${provider.name ?? provider.runtimeType}');
  }

  @override
  void providerDidFail(
    ProviderBase<Object?> provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    // Get the logger safely
    final logger = _getLoggerSafely(container);
    if (logger == null) return;

    logger.e(
      '❌ Provider error: ${provider.name ?? provider.runtimeType}\n'
      '  Error: $error',
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Safely gets the logger from the container, handling initialization order
  Logger? _getLoggerSafely(ProviderContainer container) {
    try {
      return container.read(loggerProvider);
    } catch (_) {
      // If loggerProvider is not yet initialized, return null
      return null;
    }
  }
}
