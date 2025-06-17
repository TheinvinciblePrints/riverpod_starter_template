import '../../features/authentication/authentication.dart';

abstract class IPreferenceStorage {
  Future<void> completeOnboarding();
  bool hasCompletedOnboarding();
  Future<void> setThemeMode(String mode);
  String? getThemeMode();
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> clearAll();
}
