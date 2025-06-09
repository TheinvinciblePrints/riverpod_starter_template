abstract class IPreferenceStorage {
  Future<void> completeOnboarding();
  Future<bool> hasCompletedOnboarding();
}