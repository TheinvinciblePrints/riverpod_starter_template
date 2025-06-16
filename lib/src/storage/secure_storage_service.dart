import 'package:flutter_riverpod_starter_template/src/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'interface/interface.dart';

class SecureStorageService implements ISecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  final String _accessToken = ConstantStrings.accessToken;
  final String _refreshToken = ConstantStrings.refreshToken;

  @override
  Future<void> saveAccessToken(String token) =>
      _storage.write(key: _accessToken, value: token);

  @override
  Future<String?> getAccessToken() {
    return _storage.read(key: _accessToken);
  }

  @override
  Future<void> clearAccessToken() {
    return _storage.delete(key: _accessToken);
  }

  @override
  Future<void> clearRefreshToken() {
    return _storage.delete(key: _refreshToken);
  }

  @override
  Future<String?> getRefreshToken() {
    return _storage.read(key: _refreshToken);
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) {
    return _storage.write(key: _refreshToken, value: refreshToken);
  }

  @override
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
