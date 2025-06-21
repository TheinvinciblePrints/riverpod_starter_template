import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// User model representing authenticated user data from the API
@freezed
abstract class User with _$User {
  /// Creates a user instance with all required and optional fields
  const factory User({
    /// Unique identifier for the user
    required int id,

    /// Username used for login
    required String username,

    /// User's email address
    required String email,

    /// User's first name
    required String firstName,

    /// User's last name
    required String lastName,

    /// User's gender (can be 'male', 'female', or 'other')
    required String gender,

    /// URL to user's profile image
    required String image,

    /// JWT access token for API authentication
    String? accessToken,

    /// JWT refresh token for obtaining new access tokens
    String? refreshToken,
  }) = _User;

  /// Creates a [User] from JSON map
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
