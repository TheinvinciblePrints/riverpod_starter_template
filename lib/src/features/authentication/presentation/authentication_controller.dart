import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_error_handler.dart';

import '../../../network/api_result.dart';
import '../../../network/network_failures.dart';
import '../../../shared/base/base_state_notifier.dart';
import '../application/auth_service.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';
import '../domain/login_request.dart';
import 'authentication_state.dart';

class AuthenticationController extends BaseStateNotifier<AuthenticationState> {
  AuthenticationController(Ref ref, this._authService)
    : super(ref, const AuthenticationState.initial());

  final AuthService _authService;
  String _username = '';
  String _password = '';

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
      // Validate inputs using service's validation method
      final validationError = _authService.validateCredentials(
        _username,
        _password,
      );
      if (validationError != null) {
        state = AuthenticationState.unauthenticated(validationError);
        return;
      }

      // Create login request
      final loginRequest = LoginRequest(
        username: _username,
        password: _password,
      );

      // Call login through the service layer
      final result = await _authService.login(request: loginRequest);

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
      await _authService.logout();
      state = const AuthenticationState.unauthenticated();
    } catch (e) {
      // Handle any errors during logout
      state = AuthenticationState.unauthenticated(
        'Error during logout: ${e.toString()}',
      );
    }
  }
}

/// The controller provider now depends on authServiceProvider being ready
/// Using keepAlive to prevent the provider from being disposed between screens
final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationController, AuthenticationState>((ref) {
      // Access the authService async value
      final authServiceAsync = ref.watch(authServiceProvider);

      // Keep the provider alive while in login flow
      ref.keepAlive();

      // Use valueOrNull to handle loading state
      final authService =
          authServiceAsync.valueOrNull ?? _createEmptyAuthService(ref);

      return AuthenticationController(ref, authService);
    });

/// Creates a placeholder auth service that will be used until the real one is loaded
AuthService _createEmptyAuthService(Ref ref) {
  return AuthService(_EmptyAuthRepository());
}

/// A placeholder auth repository implementation for use until the real one is loaded
class _EmptyAuthRepository with NetworkErrorHandler implements AuthRepository {
  @override
  Future<ApiResult<User>> getCurrentUser() async => ApiResult.error(
    error: BadRequestNetworkFailure(
      message: 'Authentication service is initializing, please wait...',
    ),
  );

  @override
  Future<ApiResult<User>> login({required LoginRequest request}) async {
    // This will only be called if someone tries to login before the repository is fully initialized
    return ApiResult.error(
      error: BadRequestNetworkFailure(
        message: 'Authentication service is initializing, please wait...',
      ),
    );
  }

  @override
  Future<void> logout() async {
    // No-op implementation
  }
}
