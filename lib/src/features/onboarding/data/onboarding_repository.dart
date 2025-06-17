import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/providers/global_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../storage/storage.dart';

part 'onboarding_repository.g.dart';

class OnboardingRepository {
  OnboardingRepository(this.preferenceStorage);
  final IPreferenceStorage preferenceStorage;

  Future<void> setOnboardingComplete() async {
    await preferenceStorage.completeOnboarding();
  }

  bool isOnboardingComplete() => preferenceStorage.hasCompletedOnboarding();
}

@Riverpod(keepAlive: true)
Future<OnboardingRepository> onboardingRepository(Ref ref) async {
  final sharedPreferences = await ref.watch(preferenceStorageServiceProvider.future);
  return OnboardingRepository(sharedPreferences);
}
