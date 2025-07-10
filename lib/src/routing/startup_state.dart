import 'package:freezed_annotation/freezed_annotation.dart';

part 'startup_state.freezed.dart';

@freezed
sealed class StartupState with _$StartupState {
  const factory StartupState.loading({@Default(false) bool isRetrying}) = StartupLoading;
  const factory StartupState.error([
    String? message,
    Object? errorObject,
    @Default(false) bool isRetrying,
  ]) = StartupError;
  const factory StartupState.unauthenticated({@Default(false) bool isRetrying}) = StartupUnauthenticated;
  const factory StartupState.completed({
    required bool didCompleteOnboarding,
    required bool isLoggedIn,
    @Default(false) bool isRetrying,
  }) = StartupCompleted;
}
