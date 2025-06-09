import 'package:flutter_riverpod_starter_template/src/constants/constant_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interface/interface.dart';

class PreferenceStorageService implements IPreferenceStorage {
  final SharedPreferences _prefs;

  PreferenceStorageService(this._prefs);

  final String _onboardingCompleted = ConstantStrings.onboardingCompleted;

  @override
  Future<void> completeOnboarding() async {
    await _prefs.setBool(_onboardingCompleted, true);
  }

  @override
  Future<bool> hasCompletedOnboarding() async {
    return _prefs.getBool(_onboardingCompleted) ?? false;
  }
}
