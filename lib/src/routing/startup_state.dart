import 'package:freezed_annotation/freezed_annotation.dart';

part 'startup_state.freezed.dart';

@freezed
abstract class StartupState with _$StartupState {
  const factory StartupState({
    @Default(true) bool isLoading,
    @Default(false) bool hasError,
    String? errorMessage,
    Object? errorObject,
    @Default(false) bool didCompleteOnboarding,
    @Default(false) bool isLoggedIn,
  }) = _StartupState;
}
