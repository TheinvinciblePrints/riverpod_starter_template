import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/base/base_state_notifier.dart';
import '../data/auth_repository.dart';
import '../domain/app_user.dart';
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
    final repoAsync = ref.read(authRepositoryProvider);
    final repo = repoAsync.maybeWhen(data: (repo) => repo, orElse: () => null);
    if (repo == null) {
      state = const AuthenticationState.unauthenticated('Repository not ready');
      return;
    }
    try {
      if (_username.isEmpty) {
        state = const AuthenticationState.unauthenticated('Invalid Username');
        return;
      }
      if (_password.isEmpty) {
        state = const AuthenticationState.unauthenticated('Invalid Password');
        return;
      }
      await repo.login(_username, _password);
      final user = User(
        id: 1,
        username: _username,
        email: '',
        firstName: '',
        lastName: '',
        gender: '',
        image: '',
      );
      state = AuthenticationState.authenticated(user: user);
    } catch (e) {
      state = AuthenticationState.unauthenticated(e.toString());
    }
  }

  Future<void> logout() async {
    final repoAsync = ref.read(authRepositoryProvider);
    final repo = repoAsync.maybeWhen(data: (repo) => repo, orElse: () => null);
    if (repo == null) {
      state = const AuthenticationState.unauthenticated('Repository not ready');
      return;
    }
    await repo.logout();
    state = const AuthenticationState.unauthenticated();
  }
}

final authenticationNotifierProvider =
    StateNotifierProvider<AuthenticationController, AuthenticationState>(
      (ref) => AuthenticationController(ref),
    );
