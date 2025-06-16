// logger_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

import '../../flavors.dart';

final loggerProvider = Provider<Logger>((ref) {
  final logger = Logger('AppLogger');

  // Clear previous listeners if any
  Logger.root.clearListeners();

  // Set the log level based on the flavor
  if (F.isProduction) {
    Logger.root.level = Level.WARNING;
  } else if (F.isStaging) {
    Logger.root.level = Level.INFO;
  } else {
    Logger.root.level = Level.ALL; // for dev/debug
  }

  // Attach a listener for log output
  Logger.root.onRecord.listen((record) {
    final output =
        '[${record.level.name}] ${record.time.toIso8601String()} (${record.loggerName}): ${record.message}';

    if (record.error != null) {
      print('$output\nError: ${record.error}');
    } else {
      print(output);
    }

    if (record.stackTrace != null) {
      print('StackTrace:\n${record.stackTrace}');
    }
  });

  logger.info('Logger initialized for ${F.name}');

  return logger;
});
