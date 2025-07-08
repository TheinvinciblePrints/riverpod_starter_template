import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_client.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_result.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_error_handler.dart';
import 'package:flutter_riverpod_starter_template/src/storage/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/env/env.dart';
import '../../../network/network_failures.dart';
import '../../../providers/global_providers.dart';
import '../domain/app_user.dart';
import '../domain/login_request.dart';

part 'auth_repository.g.dart';

class AuthRepository with NetworkErrorHandler {
  final IPreferenceStorage _preferenceStorage;
  final ISecureStorage _secureStorage;
  final ApiClient _apiClient;

  AuthRepository(this._preferenceStorage, this._secureStorage, this._apiClient);

  Future<ApiResult<User>> getCurrentUser() async {
    try {
      final response = await _apiClient.get('${Env.dummyJsonApiUrl}/user/me');

      // Parse user from response
      final userData = response.data;

      if (userData == null) {
        // Directly return an error result instead of throwing an exception
        return ApiResult.error(
          error: DefaultErrorNetworkFailure(
            message: 'Failed to get user data, no user data returned',
            statusCode: response.statusCode,
          ),
        );
      }

      final user = User.fromJson(userData);

      // Store tokens securely
      if (user.accessToken != null) {
        await _secureStorage.saveAccessToken(user.accessToken!);
      }

      if (user.refreshToken != null) {
        await _secureStorage.saveRefreshToken(user.refreshToken!);
      }

      // Save user data
      await _preferenceStorage.saveUser(user);

      return ApiResult.success(data: user);
    } catch (error, stackTrace) {
      final failure = handleException(error, stackTrace);
      return ApiResult.error(error: failure);
    }
  }

  Future<ApiResult<User>> login({required LoginRequest request}) async {
    try {
      final response = await _apiClient.post(
        '${Env.dummyJsonApiUrl}/auth/login',
        body: request.toJson(),
      );

      // Parse user from response
      final userData = response.data;

      if (userData == null) {
        // Directly return an error result instead of throwing an exception
        return ApiResult.error(
          error: DefaultErrorNetworkFailure(
            message: 'Login failed, no user data returned',
            statusCode: response.statusCode,
          ),
        );
      }

      final user = User.fromJson(userData);

      // Store tokens securely
      if (user.accessToken != null) {
        await _secureStorage.saveAccessToken(user.accessToken!);
      }

      if (user.refreshToken != null) {
        await _secureStorage.saveRefreshToken(user.refreshToken!);
      }

      // Save user data
      await _preferenceStorage.saveUser(user);

      return ApiResult.success(data: user);
    } catch (error, stackTrace) {
      final failure = handleException(error, stackTrace);
      return ApiResult.error(error: failure);
    }
  }

  Future<void> logout() async {
    Future.wait([_secureStorage.clearAll(), _preferenceStorage.clearAll()]);
  }
}

@Riverpod(keepAlive: true)
Future<AuthRepository> authRepository(Ref ref) async {
  final preferenceStorage = await ref.watch(
    preferenceStorageServiceProvider.future,
  );
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final apiClient = await ref.watch(apiClientProvider.future);

  return AuthRepository(preferenceStorage, secureStorage, apiClient);
}
