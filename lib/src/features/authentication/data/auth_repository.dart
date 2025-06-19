import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_client.dart';
import 'package:flutter_riverpod_starter_template/src/network/connection_checker.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_exception.dart';
import 'package:flutter_riverpod_starter_template/src/storage/storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../providers/storage_providers.dart';
import '../domain/app_user.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<void> saveUser(User user);
}

class AuthRepositoryImpl implements AuthRepository {
  final IPreferenceStorage _preferenceStorage;
  final ISecureStorage _secureStorage;
  final ApiClient _apiClient;

  AuthRepositoryImpl(
    this._preferenceStorage,
    this._secureStorage,
    this._apiClient,
  );

  @override
  Future<User?> getCurrentUser() async {
    // Check for internet connection before attempting to get user
    if (_apiClient is ApiClientImpl) {
      final checker = (_apiClient).connectionChecker;
      if (await checker.isConnected() == NetworkStatus.offline) {
        throw NetworkExceptions.noInternetConnection();
      }
    }
    return await _preferenceStorage.getUser();
  }

  @override
  Future<void> login(String username, String password) async {
    // Simulate a network call and validation
    await Future.delayed(const Duration(milliseconds: 800));
    if (username != 'user' || password != 'password') {
      throw Exception('Invalid credentials');
    }
    // Save user to storage or set session as needed
    await _preferenceStorage.saveUser(
      User(
        id: 1,
        username: username,
        email: 'user@example.com',
        firstName: 'First',
        lastName: 'Last',
        gender: 'other',
        image: '',
      ),
    );
  }

  @override
  Future<void> logout() async {
    Future.wait([_secureStorage.clearAll(), _preferenceStorage.clearAll()]);
  }

  @override
  Future<void> saveUser(User user) async {
    _preferenceStorage.saveUser(user);
  }
}

@Riverpod(keepAlive: true)
Future<AuthRepository> authRepository(Ref ref) async {
  // Replace the following with the actual providers for IPreferenceStorage, ISecureStorage, and ApiClient
  final preferenceStorage = await ref.watch(
    preferenceStorageServiceProvider.future,
  );
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final apiClient = ref.watch(apiClientProvider);

  return AuthRepositoryImpl(preferenceStorage, secureStorage, apiClient);
}
