import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_error_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../network/api_result.dart';
import '../../../network/network_failures.dart';
import '../application/auth_service.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/login_request.dart';
import 'authentication_state.dart';

part 'authentication_controller.g.dart';

@riverpod
class Authentication extends _$Authentication {
  // Don't use late final here - it causes issues when the controller rebuilds
  AuthService? _authService;
  String _username = '';
  String _password = '';

  @override
  AuthenticationState build() {
    // Listen to auth service changes, but handle the assignment carefully
    ref.listen(authServiceProvider, (previous, next) {
      if (next.hasValue) {
        _authService = next.value;
      } else {
        _authService ??= _createEmptyAuthService(ref);
      }
    });

    // Initial setup
    final authServiceAsync = ref.watch(authServiceProvider);
    _authService ??=
        authServiceAsync.valueOrNull ?? _createEmptyAuthService(ref);

    // Initial state
    return const AuthenticationState.initial();
  }

  void setUsername(String username) {
    _username = username;
    if (state is AuthenticationUnauthenticated) {
      state = const AuthenticationState.unauthenticated();
    }
  }

  void setPassword(String password) {
    _password = password;
    if (state is AuthenticationUnauthenticated) {
      state = const AuthenticationState.unauthenticated();
    }
  }

  Future<void> login() async {
    state = const AuthenticationState.loading();

    try {
      // Ensure auth service is available
      if (_authService == null) {
        final authServiceAsync = await ref.read(authServiceProvider.future);
        _authService = authServiceAsync;
      }

      final service = _authService!; // Non-null assertion is safe here

      final validationError = service.validateCredentials(_username, _password);

      if (validationError != null) {
        state = AuthenticationState.unauthenticated(validationError);
        return;
      }

      final loginRequest = LoginRequest(
        username: _username,
        password: _password,
        expiresInMins: 1440,
      );

      final result = await service.login(request: loginRequest);

      state = switch (result) {
        Success(data: final user) => AuthenticationState.authenticated(
          user: user,
        ),
        Error(error: final error) => AuthenticationState.unauthenticated(
          error.message,
        ),
      };
    } catch (e) {
      state = AuthenticationState.unauthenticated(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      // Ensure auth service is available
      if (_authService == null) {
        final authServiceAsync = await ref.read(authServiceProvider.future);
        _authService = authServiceAsync;
      }

      await _authService!.logout();
      state = const AuthenticationState.unauthenticated();
    } catch (e) {
      state = AuthenticationState.unauthenticated(
        'Error during logout: ${e.toString()}',
      );
    }
  }

  /// Helper for placeholder AuthService while loading
  AuthService _createEmptyAuthService(Ref ref) {
    return AuthService(_EmptyAuthRepository());
  }
}

/// Placeholder for fallback AuthRepository
class _EmptyAuthRepository with NetworkErrorHandler implements AuthRepository {
  @override
  Future<ApiResult<User>> getCurrentUser() async => ApiResult.error(
    error: BadRequestNetworkFailure(
      message: 'Authentication service is initializing, please wait...',
    ),
  );

  @override
  Future<ApiResult<User>> login({required LoginRequest request}) async =>
      ApiResult.error(
        error: BadRequestNetworkFailure(
          message: 'Authentication service is initializing, please wait...',
        ),
      );

  @override
  Future<void> logout() async {}
}
