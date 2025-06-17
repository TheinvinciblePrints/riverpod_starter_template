import 'dart:convert';

import 'package:flutter_riverpod_starter_template/src/constants/constant_strings.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/domain/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interface/interface.dart';

class PreferenceStorageService implements IPreferenceStorage {
  final SharedPreferences _prefs;

  PreferenceStorageService(this._prefs);

  final String _onboardingCompleted = ConstantStrings.onboardingCompleted;
  final String _themeMode = ConstantStrings.themeMode;

  @override
  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingCompleted, true);
  }

  @override
  bool hasCompletedOnboarding() {
    return _prefs.getBool(_onboardingCompleted) ?? false;
  }

  @override
  String? getThemeMode() {
    return _prefs.getString(_themeMode) ?? 'system';
  }

  @override
  Future<void> setThemeMode(String mode) async {
    await _prefs.setString(_themeMode, mode);
  }

  @override
  Future<User?> getUser() async {
    final jsonString = _prefs.getString('user');

    if (jsonString == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return User.fromJson(jsonMap);
  }

  @override
  Future<void> saveUser(User user) async {
    final jsonString = jsonEncode(user.toJson());
    await _prefs.setString('user', jsonString);
  }

  @override
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
