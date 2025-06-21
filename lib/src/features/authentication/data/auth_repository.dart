import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_client.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_result_freezed.dart';
import 'package:flutter_riverpod_starter_template/src/network/error_handler.dart';
import 'package:flutter_riverpod_starter_template/src/providers/error_handler_provider.dart';
import 'package:flutter_riverpod_starter_template/src/storage/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/env/env.dart';
import '../../../providers/storage_providers.dart';
import '../domain/app_user.dart';
import '../domain/login_request.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<ApiResult<User>> login({required LoginRequest request});
  Future<void> logout();
  Future<User?> getCurrentUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final IPreferenceStorage _preferenceStorage;
  final ISecureStorage _secureStorage;
  final ApiClient _apiClient;
  final ErrorHandler _errorHandler;

  AuthRepositoryImpl(
    this._preferenceStorage,
    this._secureStorage,
    this._apiClient,
    this._errorHandler,
  );

  @override
  Future<User?> getCurrentUser() async {
    return await _preferenceStorage.getUser();
  }

  @override
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
        return _errorHandler.error<User>(
          message: 'Failed to login: Empty response',
          statusCode: response.statusCode,
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
    } catch (e, stackTrace) {
      // Handle exceptions and convert them to ApiResult.error
      return ApiResult.error(
        error: _errorHandler.handleException(e, stackTrace),
      );
    }
  }

  @override
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
  final apiClient = ref.watch(apiClientProvider);
  final errorHandler = ref.watch(errorHandlerProvider);

  return AuthRepositoryImpl(
    preferenceStorage,
    secureStorage,
    apiClient,
    errorHandler,
  );
}
