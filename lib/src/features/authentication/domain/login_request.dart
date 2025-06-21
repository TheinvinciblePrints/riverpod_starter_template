import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

/// Model representing a login request payload.
@freezed
abstract class LoginRequest with _$LoginRequest {
  /// Creates a login request with username and password.
  const factory LoginRequest({
    /// The user's username or email.
    required String username,
    
    /// The user's password.
    required String password,
    
  }) = _LoginRequest;

  /// Creates a [LoginRequest] from JSON map.
  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}