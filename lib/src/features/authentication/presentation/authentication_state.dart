import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/app_user.dart';

part 'authentication_state.freezed.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = AuthenticationInitial;
  const factory AuthenticationState.loading() = AuthenticationLoading;
  const factory AuthenticationState.authenticated({required User user}) =
      AuthenticationAuthenticated;
  const factory AuthenticationState.unauthenticated([String? errorMessage]) =
      AuthenticationUnauthenticated;
}
