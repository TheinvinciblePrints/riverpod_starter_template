// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'startup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StartupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StartupState()';
}


}

/// @nodoc
class $StartupStateCopyWith<$Res>  {
$StartupStateCopyWith(StartupState _, $Res Function(StartupState) __);
}


/// @nodoc


class StartupLoading implements StartupState {
  const StartupLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StartupState.loading()';
}


}




/// @nodoc


class StartupError implements StartupState {
  const StartupError([this.message, this.errorObject]);
  

 final  String? message;
 final  Object? errorObject;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupErrorCopyWith<StartupError> get copyWith => _$StartupErrorCopyWithImpl<StartupError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorObject, errorObject));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(errorObject));

@override
String toString() {
  return 'StartupState.error(message: $message, errorObject: $errorObject)';
}


}

/// @nodoc
abstract mixin class $StartupErrorCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory $StartupErrorCopyWith(StartupError value, $Res Function(StartupError) _then) = _$StartupErrorCopyWithImpl;
@useResult
$Res call({
 String? message, Object? errorObject
});




}
/// @nodoc
class _$StartupErrorCopyWithImpl<$Res>
    implements $StartupErrorCopyWith<$Res> {
  _$StartupErrorCopyWithImpl(this._self, this._then);

  final StartupError _self;
  final $Res Function(StartupError) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? errorObject = freezed,}) {
  return _then(StartupError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,freezed == errorObject ? _self.errorObject : errorObject ,
  ));
}


}

/// @nodoc


class StartupUnauthenticated implements StartupState {
  const StartupUnauthenticated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupUnauthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StartupState.unauthenticated()';
}


}




/// @nodoc


class StartupCompleted implements StartupState {
  const StartupCompleted({required this.didCompleteOnboarding, required this.isLoggedIn});
  

 final  bool didCompleteOnboarding;
 final  bool isLoggedIn;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupCompletedCopyWith<StartupCompleted> get copyWith => _$StartupCompletedCopyWithImpl<StartupCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupCompleted&&(identical(other.didCompleteOnboarding, didCompleteOnboarding) || other.didCompleteOnboarding == didCompleteOnboarding)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn));
}


@override
int get hashCode => Object.hash(runtimeType,didCompleteOnboarding,isLoggedIn);

@override
String toString() {
  return 'StartupState.completed(didCompleteOnboarding: $didCompleteOnboarding, isLoggedIn: $isLoggedIn)';
}


}

/// @nodoc
abstract mixin class $StartupCompletedCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory $StartupCompletedCopyWith(StartupCompleted value, $Res Function(StartupCompleted) _then) = _$StartupCompletedCopyWithImpl;
@useResult
$Res call({
 bool didCompleteOnboarding, bool isLoggedIn
});




}
/// @nodoc
class _$StartupCompletedCopyWithImpl<$Res>
    implements $StartupCompletedCopyWith<$Res> {
  _$StartupCompletedCopyWithImpl(this._self, this._then);

  final StartupCompleted _self;
  final $Res Function(StartupCompleted) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? didCompleteOnboarding = null,Object? isLoggedIn = null,}) {
  return _then(StartupCompleted(
didCompleteOnboarding: null == didCompleteOnboarding ? _self.didCompleteOnboarding : didCompleteOnboarding // ignore: cast_nullable_to_non_nullable
as bool,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
