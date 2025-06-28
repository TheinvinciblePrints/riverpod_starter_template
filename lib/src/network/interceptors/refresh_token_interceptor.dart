import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/authentication/presentation/authentication_controller.dart';
import '../../routing/startup_notifier.dart';
import '../../storage/interface/i_secure_storage.dart';

class RefreshTokenInterceptor extends Interceptor {
  final ISecureStorage _secureStorage;
  final Ref? _ref;
  final Dio _refreshDio = Dio(); // Use separate dio instance

  RefreshTokenInterceptor(this._secureStorage, [this._ref]);

  bool _isRefreshing = false;
  final List<Function()> _queue = [];

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final requestOptions = err.requestOptions;

    if (_shouldRefresh(err)) {
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          final newToken = await _refreshToken();

          _isRefreshing = false;

          // Retry all queued requests
          for (final callback in _queue) {
            callback();
          }
          _queue.clear();

          // Retry the current request
          final response = await _retryRequest(requestOptions, newToken);
          return handler.resolve(response);
        } catch (e) {
          _isRefreshing = false;
          _queue.clear();

          // Log out user when token refresh fails
          await _logoutUser();

          return handler.reject(err);
        }
      } else {
        _queue.add(() async {
          final newToken = await _secureStorage.getAccessToken();
          final response = await _retryRequest(requestOptions, newToken ?? '');
          handler.resolve(response);
        });
      }
    } else {
      handler.next(err);
    }
  }

  bool _shouldRefresh(DioException err) {
    return err.response?.statusCode == 401 &&
        (err.requestOptions.extra['authorization'] ?? true) == true;
  }

  Future<String> _refreshToken() async {
    final refreshToken = await _secureStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw DioException(
        requestOptions: RequestOptions(),
        error: 'No refresh token available',
      );
    }

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

    final newAccessToken = response.data['accessToken'];
    final newRefreshToken = response.data['refreshToken'];

    await _secureStorage.saveAccessToken(newAccessToken);
    await _secureStorage.saveRefreshToken(newRefreshToken);

    return newAccessToken;
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions options,
    String token,
  ) {
    final newOptions = Options(
      method: options.method,
      headers: {...options.headers, 'Authorization': 'Bearer $token'},
    );

    final dio = Dio();
    return dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: newOptions,
    );
  }

  /// Handles user logout when token refresh fails
  /// Clears tokens and updates authentication state if Ref is available
  Future<void> _logoutUser() async {
    // Always clear tokens from storage
    await _secureStorage.clearAll();

    // If we have access to Riverpod ref, update auth state
    if (_ref != null) {
      try {
        // Update startup notifier to trigger router redirection
        _ref.read(startupNotifierProvider.notifier).updateLoginState(false);

        // Also update authentication controller state if needed
        // This is optional as the startup notifier should handle navigation
        if (_ref.exists(authenticationProvider)) {
          await _ref.read(authenticationProvider.notifier).logout();
        }
      } catch (e) {
        // Log error but don't rethrow - we've already cleared tokens
        print('Error updating auth state during token refresh logout: $e');
      }
    }
  }
}
