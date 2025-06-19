// logger_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../flavors.dart';

class _DummyLogger extends Logger {
  _DummyLogger() : super(printer: PrettyPrinter(methodCount: 0));
  @override
  void log(
    Level level,
    message, {
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  }) {
    // Do nothing
  }
}

final loggerProvider = Provider<Logger>((ref) {
  if (F.isDev) {
    return Logger(
      printer: PrettyPrinter(
        methodCount: 2, // Number of method calls to be displayed
        errorMethodCount: 8, // Number of method calls if stacktrace is provided
        lineLength: 120, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        // Should each log print contain a timestamp
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    );
  } else {
    return _DummyLogger();
  }
});
