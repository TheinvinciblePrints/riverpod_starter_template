import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/onboarding_repository.dart';

part 'onboarding_controller.g.dart';

@riverpod
class Onboarding extends _$Onboarding {
  @override
  FutureOr<void> build() {}

  Future<void> completeOnboarding() async {
    final onboardingRepository =
        ref.watch(onboardingRepositoryProvider).requireValue;
    state = const AsyncLoading();
    state = await AsyncValue.guard(onboardingRepository.setOnboardingComplete);
  }
}
