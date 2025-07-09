import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/dio_provider.dart';
import 'connection_checker.dart';
import 'network_exceptions.dart';

part 'api_client.g.dart';

@riverpod
Future<ApiClient> apiClient(Ref ref) async {
  final checker = ref.watch(connectionCheckerProvider);
  final dio = await ref.watch(dioProvider.future);
  return ApiClientImpl(dio: dio, connectionChecker: checker);
}


abstract class ApiClient {
  Future<Response<dynamic>> get(
    String uri, {
    String? fullUrl,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  });

  Future<Response<dynamic>> post(
    String uri, {
    required dynamic body,
    String? fullUrl,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  });

  Future<Response<dynamic>> put(
    String uri, {
    required dynamic body,
    String? fullUrl,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  });

  Future<Response<dynamic>> delete(
    String uri, {
    required dynamic body,
    String? fullUrl,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  });

  Future<Response<dynamic>> download(
    String uri,
    String savePath, {
    String? fullUrl,
    Map<String, dynamic>? headers,
    String? method,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  });
}

class ApiClientImpl implements ApiClient {
  ApiClientImpl({required this.dio, required this.connectionChecker});

  final ConnectionChecker connectionChecker;
  final Dio dio;

  @override
  Future<Response<dynamic>> delete(
    String uri, {
    required dynamic body,
    String? fullUrl,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  }) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': requireToken,
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    await _setHeader();

    return await dio.delete(
      fullUrl ?? uri,
      data: body,
      cancelToken: cancelToken,
      options: Options(headers: headers, extra: extra),
    );
  }

  @override
  Future<Response<dynamic>> download(
    String uri,
    String savePath, {
    String? fullUrl,
    String? method,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  }) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': requireToken,
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    await _setHeader();

    return await dio.download(
      fullUrl ?? uri,
      savePath,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: Options(headers: headers, extra: extra, method: method),
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<dynamic>> get(
    String uri, {
    String? fullUrl,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  }) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': requireToken,
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    await _setHeader();

    return await dio.get(
      fullUrl ?? uri,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: Options(headers: headers, extra: extra),
      onReceiveProgress: onReceiveProgress,
    );
  }

  @override
  Future<Response<dynamic>> post(
    String uri, {
    required dynamic body,
    String? fullUrl,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  }) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': requireToken,
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    await _setHeader();

    return await dio.post(
      fullUrl ?? uri,
      data: body,
      options: Options(headers: headers, extra: extra),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response<dynamic>> put(
    String uri, {
    required dynamic body,
    String? fullUrl,
    Map<String, dynamic>? headers,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool requireToken = true,
    int? timeout,
  }) async {
    await _throwExceptionIfNoConnection();
    final Map<String, dynamic> extra = {
      'url': fullUrl ?? dio.options.baseUrl,
      'authorization': requireToken,
    };

    if (timeout != null) {
      dio.options.connectTimeout = Duration(seconds: timeout);
      dio.options.receiveTimeout = Duration(seconds: timeout);
    }

    await _setHeader();

    return await dio.put(
      fullUrl ?? uri,
      data: body,
      options: Options(headers: headers, extra: extra),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  /// helper function to check if mobile has connection before making API request
  Future<void> _throwExceptionIfNoConnection() async {
    if (await connectionChecker.isConnected() == NetworkStatus.offline) {
      throw NetworkExceptions.noInternetConnection();
    }
  }

  Future<void> _setHeader() async {
    dio.options.headers = {
      // HttpHeaders.acceptHeader: appJson,
      HttpHeaders.contentTypeHeader: 'application/json',
      // Add any other headers you need here
      // 'Custom-Header': 'value',
    };
  }
}
