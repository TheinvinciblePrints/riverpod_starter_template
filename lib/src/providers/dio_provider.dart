import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/interceptors/auth_interceptor.dart';
import 'package:flutter_riverpod_starter_template/src/network/interceptors/refresh_token_interceptor.dart';
import 'package:flutter_riverpod_starter_template/src/providers/cache_provider.dart';
import 'package:flutter_riverpod_starter_template/src/providers/persistent_cache_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../flavors.dart';
import '../network/interceptors/dio_logger_interceptor.dart';
import 'storage_providers.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Dio> dio(Ref ref) async {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final cacheInterceptor = await ref.watch(cacheInterceptorProvider.future);

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
    cacheInterceptor,
    AuthInterceptor(secureStorage),
    RefreshTokenInterceptor(secureStorage, ref),
    DioLoggerInterceptor(
      requestHeader:
          !FlavorConfig
              .isProduction, // print requestHeader if only on DEV or UAT environment
      requestBody: true,
      responseBody:
          !FlavorConfig
              .isProduction, // print responseBody if only on DEV or UAT environment
      responseHeader: !FlavorConfig.isProduction,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  ]);

  return dio;
}

/// Dedicated Dio instance for countries API with persistent cache and error handling
/// This prevents cache corruption issues from affecting other API calls
@Riverpod(keepAlive: true)
Future<Dio> countriesDio(Ref ref) async {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final persistentCacheInterceptor = await ref.watch(
    persistentCacheInterceptorProvider.future,
  );
  final cacheTrackingInterceptor = await ref.watch(
    cacheTrackingInterceptorProvider.future,
  );

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
    cacheTrackingInterceptor, // Add cache tracking before cache interceptor
    persistentCacheInterceptor,
    AuthInterceptor(secureStorage),
    RefreshTokenInterceptor(secureStorage, ref),
    DioLoggerInterceptor(
      requestHeader: !FlavorConfig.isProduction,
      requestBody: true,
      responseBody: !FlavorConfig.isProduction,
      responseHeader: !FlavorConfig.isProduction,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  ]);

  return dio;
}
