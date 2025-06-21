import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/interceptors/auth_interceptor.dart';
import 'package:flutter_riverpod_starter_template/src/network/interceptors/refresh_token_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

import '../../flavors.dart';
import 'storage_providers.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);

  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      followRedirects: false,
      receiveDataWhenStatusError: true,
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(secureStorage),
    RefreshTokenInterceptor(secureStorage),
    TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
        printRequestHeaders:
            !F.isProduction, // Print request headers in non-production environments
        printResponseHeaders:
            !F.isProduction, // Print request headers in non-production environments
        printResponseMessage:
            !F.isProduction, // Print request headers in non-production environments
      ),
    ),
  ]);

  return dio;
}
