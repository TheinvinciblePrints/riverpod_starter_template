import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/localization/locale_keys.g.dart';

import '../../../network/api_result.dart';
import '../../../providers/error_handler_provider.dart';
import '../../../shared/base/base_state_notifier.dart';
import '../data/auth_repository.dart';
import '../domain/login_request.dart';
import 'authentication_state.dart';

class AuthenticationController extends BaseStateNotifier<AuthenticationState> {
  AuthenticationController(Ref ref)
    : super(ref, const AuthenticationState.initial());

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

    // Validate inputs first
    if (_username.isEmpty) {
      state =  AuthenticationState.unauthenticated(
        LocaleKeys.auth_pleaseEnterValidUsername.tr(),
      );
      return;
    }
    if (_password.isEmpty) {
      state =  AuthenticationState.unauthenticated(
        LocaleKeys.auth_pleaseEnterValidPassword.tr(),
      );
      return;
    }

    // Get the repository
    final repoAsync = ref.read(authRepositoryProvider);
    final repo = repoAsync.valueOrNull;
    if (repo == null) {
      state = const AuthenticationState.unauthenticated('Repository not ready');
      return;
    }

    // Create login request
    final loginRequest = LoginRequest(username: _username, password: _password);

    // Call login and handle the ApiResult using pattern matching
    final result = await repo.login(request: loginRequest);

    state = switch (result) {
      Success(data: final user) => AuthenticationState.authenticated(
        user: user,
      ),
      Error(error: final error) => AuthenticationState.unauthenticated(
        ref.read(errorHandlerProvider).createErrorMessage(error),
      ),
    };
  }

  Future<void> logout() async {
    final repoAsync = ref.read(authRepositoryProvider);
    final repo = repoAsync.valueOrNull;
    if (repo == null) {
      state = const AuthenticationState.unauthenticated('Repository not ready');
      return;
    }
    try {
      await repo.logout();
      state = const AuthenticationState.unauthenticated();
    } catch (e) {
      // Handle any errors during logout
      state = AuthenticationState.unauthenticated(
        'Error during logout: ${e.toString()}',
      );
    }
  }
}

final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationController, AuthenticationState>(
      (ref) => AuthenticationController(ref),
    );
