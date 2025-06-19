import 'package:freezed_annotation/freezed_annotation.dart';

part 'startup_state.freezed.dart';

@freezed
abstract class StartupState with _$StartupState {
  factory StartupState({
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    Object? errorObject,
    bool? didCompleteOnboarding,
    bool? isLoggedIn,
  }) = _StartupState;
}
