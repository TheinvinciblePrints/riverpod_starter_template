// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'authentication_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthenticationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState()';
}


}

/// @nodoc
class $AuthenticationStateCopyWith<$Res>  {
$AuthenticationStateCopyWith(AuthenticationState _, $Res Function(AuthenticationState) __);
}


/// @nodoc


class AuthenticationInitial implements AuthenticationState {
  const AuthenticationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.initial()';
}


}




/// @nodoc


class AuthenticationLoading implements AuthenticationState {
  const AuthenticationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthenticationState.loading()';
}


}




/// @nodoc


class AuthenticationAuthenticated implements AuthenticationState {
  const AuthenticationAuthenticated({required this.user});
  

 final  User user;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationAuthenticatedCopyWith<AuthenticationAuthenticated> get copyWith => _$AuthenticationAuthenticatedCopyWithImpl<AuthenticationAuthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationAuthenticated&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthenticationState.authenticated(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthenticationAuthenticatedCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationAuthenticatedCopyWith(AuthenticationAuthenticated value, $Res Function(AuthenticationAuthenticated) _then) = _$AuthenticationAuthenticatedCopyWithImpl;
@useResult
$Res call({
 User user
});




}
/// @nodoc
class _$AuthenticationAuthenticatedCopyWithImpl<$Res>
    implements $AuthenticationAuthenticatedCopyWith<$Res> {
  _$AuthenticationAuthenticatedCopyWithImpl(this._self, this._then);

  final AuthenticationAuthenticated _self;
  final $Res Function(AuthenticationAuthenticated) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AuthenticationAuthenticated(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User,
  ));
}


}

/// @nodoc


class AuthenticationUnauthenticated implements AuthenticationState {
  const AuthenticationUnauthenticated([this.errorMessage]);
  

 final  String? errorMessage;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthenticationUnauthenticatedCopyWith<AuthenticationUnauthenticated> get copyWith => _$AuthenticationUnauthenticatedCopyWithImpl<AuthenticationUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthenticationUnauthenticated&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'AuthenticationState.unauthenticated(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AuthenticationUnauthenticatedCopyWith<$Res> implements $AuthenticationStateCopyWith<$Res> {
  factory $AuthenticationUnauthenticatedCopyWith(AuthenticationUnauthenticated value, $Res Function(AuthenticationUnauthenticated) _then) = _$AuthenticationUnauthenticatedCopyWithImpl;
@useResult
$Res call({
 String? errorMessage
});




}
/// @nodoc
class _$AuthenticationUnauthenticatedCopyWithImpl<$Res>
    implements $AuthenticationUnauthenticatedCopyWith<$Res> {
  _$AuthenticationUnauthenticatedCopyWithImpl(this._self, this._then);

  final AuthenticationUnauthenticated _self;
  final $Res Function(AuthenticationUnauthenticated) _then;

/// Create a copy of AuthenticationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = freezed,}) {
  return _then(AuthenticationUnauthenticated(
freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
