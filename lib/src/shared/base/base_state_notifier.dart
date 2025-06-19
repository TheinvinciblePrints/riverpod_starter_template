import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../providers/logger_provider.dart';

abstract class BaseStateNotifier<T> extends StateNotifier<T> {
  final Ref _ref;
  late final Logger _logger;

  BaseStateNotifier(this._ref, T initialState) : super(initialState) {
    _logger = _ref.read(loggerProvider);
    onInit();
  }

  /// Protected logger getter for subclasses (not public)
  @protected
  Logger get logger => _logger;

  /// Expose the protected ref getter in BaseStateNotifier so it can be used in other classes for provider reads.
  Ref get ref => _ref;

  /// Lifecycle hook (optional)
  void onInit() {}
}
