import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/error_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'error_handler_provider.g.dart';

/// Provider for the ErrorHandler singleton
@Riverpod(keepAlive: true)
ErrorHandler errorHandler(Ref ref) {
  return ErrorHandler();
}
