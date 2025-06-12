// lib/network/interceptor/refresh_token_interceptor.dart
import 'package:dio/dio.dart';

import '../../storage/interface/i_secure_storage.dart';

class RefreshTokenInterceptor extends Interceptor {
  final ISecureStorage _secureStorage;
  final Dio _refreshDio = Dio(); // Plain Dio instance

  RefreshTokenInterceptor(this._secureStorage);

  bool _isRefreshing = false;
  final List<Function()> _queue = [];

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    // Check if error is 401 Unauthorized and token is required
    if (_shouldRefresh(err)) {
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final newToken =
              await _refreshToken(); // Refresh token using plain Dio
          _isRefreshing = false;

          // Retry all queued requests with new token
          for (final callback in _queue) {
            callback();
          }
          _queue.clear();

          // Retry the original request
          final response = await _retryWithNewToken(requestOptions, newToken);
          return handler.resolve(response);
        } catch (e) {
          _isRefreshing = false;
          _queue.clear();
          return handler.reject(err);
        }
      } else {
        // Queue the current request to retry after refresh completes
        _queue.add(() async {
          final token = await _getToken();
          final response = await _retryWithNewToken(requestOptions, token);
          handler.resolve(response);
        });
      }
    } else {
      return handler.next(err);
    }
  }

  bool _shouldRefresh(DioException err) {
    return err.response?.statusCode == 401 &&
        (err.requestOptions.extra['authorization'] ?? true) == true;
  }

  Future<String> _refreshToken() async {
    final refreshToken = await _getRefreshToken();

    final response = await _refreshDio.post(
      'https://your-api.com/auth/refresh',
      data: {'refreshToken': refreshToken},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    final newToken = response.data['accessToken'];
    await _saveToken(newToken);
    return newToken;
  }

  Future<Response<dynamic>> _retryWithNewToken(
    RequestOptions options,
    String token,
  ) {
    final newOptions = Options(
      method: options.method,
      headers: {...options.headers, 'Authorization': 'Bearer $token'},
    );

    return Dio().request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: newOptions,
    );
  }

  Future<String> _getRefreshToken() async {
    // Replace with your secure storage or auth provider
    return await _secureStorage.getRefreshToken() ?? '';
  }

  Future<String> _getToken() async {
    return await _secureStorage.getAccessToken() ?? '';
  }

  Future<void> _saveToken(String token) async {
    await _secureStorage.saveAccessToken(token);
  }
}
