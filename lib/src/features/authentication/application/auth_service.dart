import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/domain/login_request.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_result.dart';

import '../data/auth_repository.dart';

/// Authentication service class to centralize business logic
class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  /// Performs user login with validation and error handling
  Future<ApiResult<User>> login({required LoginRequest request}) async {
    // Delegate to repository
    return _repository.login(request: request);
  }

  /// Gets the current authenticated user
  /// Returns ApiResult.success with User if authenticated
  /// Returns ApiResult.error if authentication fails or an error occurs
  Future<ApiResult<User>> getCurrentUser() => _repository.getCurrentUser();

  /// Logs out the current user
  Future<void> logout() => _repository.logout();

  /// Validate user credentials (username and password)
  /// Returns true if credentials are valid, false otherwise
  String? validateCredentials(String username, String password) {
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    return null; // No validation errors
  }
}

/// Provider for the AuthService as a FutureProvider to properly handle async repository initialization
final authServiceProvider = FutureProvider.autoDispose<AuthService>((
  ref,
) async {
  // Wait for the repository to be fully initialized
  final authRepo = await ref.watch(authRepositoryProvider.future);

  return AuthService(authRepo);
});
