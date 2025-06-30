import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/onboarding_repository.dart';

part 'onboarding_logic.g.dart';

@riverpod
Future<void> completeOnboarding(Ref ref) async {
  final repo = await ref.watch(onboardingRepositoryProvider.future);
  await repo.setOnboardingComplete();
}

@riverpod
Future<bool> isOnboardingComplete(Ref ref) async {
  final repo = await ref.watch(onboardingRepositoryProvider.future);
  return repo.isOnboardingComplete();
}
