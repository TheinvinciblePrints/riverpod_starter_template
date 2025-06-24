// logger_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../flavors.dart';

part 'logger_provider.g.dart';

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
    // Do nothing in production
  }
}

@riverpod
Logger logger(Ref ref) {
  if (F.isDev) {
    return Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    );
  } else {
    return _DummyLogger();
  }
}
