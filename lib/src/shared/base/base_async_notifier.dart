import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/providers/logger_provider.dart';
import 'package:logging/logging.dart';

abstract class BaseAsyncNotifier<T> extends AsyncNotifier<T> {
  late final Logger _logger;

  @override
  FutureOr<T> build() {
    _logger = ref.read(loggerProvider);
    return onInit();
  }

  FutureOr<T> onInit();

  /// Protected logger getter for subclasses (not public)
  @protected
  Logger get logger => _logger;
}
