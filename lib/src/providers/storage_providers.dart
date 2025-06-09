import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage/storage.dart';

part 'storage_providers.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(Ref ref) {
  return SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) {
  return const FlutterSecureStorage();
}

@Riverpod(keepAlive: true)
Future<IPreferenceStorage> preferenceStorage(Ref ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return PreferenceStorageService(prefs);
}

@Riverpod(keepAlive: true)
ISecureStorage secureStorageService(Ref ref) {
  final storage = ref.watch(secureStorageProvider);
  return SecureStorageService(storage);
}
