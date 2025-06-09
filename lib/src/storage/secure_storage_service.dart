import 'package:flutter_riverpod_starter_template/src/constants/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'interface/interface.dart';

class SecureStorageService implements ISecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  final String _accessToken = ConstantStrings.accessToken;

  @override
  Future<void> saveToken(String token) =>
      _storage.write(key: _accessToken, value: token);

  @override
  Future<String?> getToken() => _storage.read(key: _accessToken);

  @override
  Future<void> clearToken() => _storage.delete(key: _accessToken);
}
