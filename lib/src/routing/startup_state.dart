import 'package:freezed_annotation/freezed_annotation.dart';

part 'startup_state.freezed.dart';

@freezed
sealed class StartupState with _$StartupState {
  const factory StartupState.loading() = StartupLoading;
  const factory StartupState.error([String? message, Object? errorObject]) =
      StartupError;
  const factory StartupState.unauthenticated() = StartupUnauthenticated;
  const factory StartupState.completed({
    required bool didCompleteOnboarding,
    required bool isLoggedIn,
  }) = StartupCompleted;
}
