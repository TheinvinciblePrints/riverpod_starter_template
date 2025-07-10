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

 bool get isRetrying;
/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupStateCopyWith<StartupState> get copyWith => _$StartupStateCopyWithImpl<StartupState>(this as StartupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupState&&(identical(other.isRetrying, isRetrying) || other.isRetrying == isRetrying));
}


@override
int get hashCode => Object.hash(runtimeType,isRetrying);

@override
String toString() {
  return 'StartupState(isRetrying: $isRetrying)';
}


}

/// @nodoc
abstract mixin class $StartupStateCopyWith<$Res>  {
  factory $StartupStateCopyWith(StartupState value, $Res Function(StartupState) _then) = _$StartupStateCopyWithImpl;
@useResult
$Res call({
 bool isRetrying
});




}
/// @nodoc
class _$StartupStateCopyWithImpl<$Res>
    implements $StartupStateCopyWith<$Res> {
  _$StartupStateCopyWithImpl(this._self, this._then);

  final StartupState _self;
  final $Res Function(StartupState) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isRetrying = null,}) {
  return _then(_self.copyWith(
isRetrying: null == isRetrying ? _self.isRetrying : isRetrying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class StartupLoading implements StartupState {
  const StartupLoading({this.isRetrying = false});
  

@override@JsonKey() final  bool isRetrying;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupLoadingCopyWith<StartupLoading> get copyWith => _$StartupLoadingCopyWithImpl<StartupLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupLoading&&(identical(other.isRetrying, isRetrying) || other.isRetrying == isRetrying));
}


@override
int get hashCode => Object.hash(runtimeType,isRetrying);

@override
String toString() {
  return 'StartupState.loading(isRetrying: $isRetrying)';
}


}

/// @nodoc
abstract mixin class $StartupLoadingCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory $StartupLoadingCopyWith(StartupLoading value, $Res Function(StartupLoading) _then) = _$StartupLoadingCopyWithImpl;
@override @useResult
$Res call({
 bool isRetrying
});




}
/// @nodoc
class _$StartupLoadingCopyWithImpl<$Res>
    implements $StartupLoadingCopyWith<$Res> {
  _$StartupLoadingCopyWithImpl(this._self, this._then);

  final StartupLoading _self;
  final $Res Function(StartupLoading) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRetrying = null,}) {
  return _then(StartupLoading(
isRetrying: null == isRetrying ? _self.isRetrying : isRetrying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StartupError implements StartupState {
  const StartupError([this.message, this.errorObject, this.isRetrying = false]);
  

 final  String? message;
 final  Object? errorObject;
@override@JsonKey() final  bool isRetrying;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupErrorCopyWith<StartupError> get copyWith => _$StartupErrorCopyWithImpl<StartupError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupError&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.errorObject, errorObject)&&(identical(other.isRetrying, isRetrying) || other.isRetrying == isRetrying));
}


@override
int get hashCode => Object.hash(runtimeType,message,const DeepCollectionEquality().hash(errorObject),isRetrying);

@override
String toString() {
  return 'StartupState.error(message: $message, errorObject: $errorObject, isRetrying: $isRetrying)';
}


}

/// @nodoc
abstract mixin class $StartupErrorCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory $StartupErrorCopyWith(StartupError value, $Res Function(StartupError) _then) = _$StartupErrorCopyWithImpl;
@override @useResult
$Res call({
 String? message, Object? errorObject, bool isRetrying
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
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? errorObject = freezed,Object? isRetrying = null,}) {
  return _then(StartupError(
freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,freezed == errorObject ? _self.errorObject : errorObject ,null == isRetrying ? _self.isRetrying : isRetrying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StartupUnauthenticated implements StartupState {
  const StartupUnauthenticated({this.isRetrying = false});
  

@override@JsonKey() final  bool isRetrying;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupUnauthenticatedCopyWith<StartupUnauthenticated> get copyWith => _$StartupUnauthenticatedCopyWithImpl<StartupUnauthenticated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupUnauthenticated&&(identical(other.isRetrying, isRetrying) || other.isRetrying == isRetrying));
}


@override
int get hashCode => Object.hash(runtimeType,isRetrying);

@override
String toString() {
  return 'StartupState.unauthenticated(isRetrying: $isRetrying)';
}


}

/// @nodoc
abstract mixin class $StartupUnauthenticatedCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory $StartupUnauthenticatedCopyWith(StartupUnauthenticated value, $Res Function(StartupUnauthenticated) _then) = _$StartupUnauthenticatedCopyWithImpl;
@override @useResult
$Res call({
 bool isRetrying
});




}
/// @nodoc
class _$StartupUnauthenticatedCopyWithImpl<$Res>
    implements $StartupUnauthenticatedCopyWith<$Res> {
  _$StartupUnauthenticatedCopyWithImpl(this._self, this._then);

  final StartupUnauthenticated _self;
  final $Res Function(StartupUnauthenticated) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isRetrying = null,}) {
  return _then(StartupUnauthenticated(
isRetrying: null == isRetrying ? _self.isRetrying : isRetrying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class StartupCompleted implements StartupState {
  const StartupCompleted({required this.didCompleteOnboarding, required this.isLoggedIn, this.isRetrying = false});
  

 final  bool didCompleteOnboarding;
 final  bool isLoggedIn;
@override@JsonKey() final  bool isRetrying;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupCompletedCopyWith<StartupCompleted> get copyWith => _$StartupCompletedCopyWithImpl<StartupCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupCompleted&&(identical(other.didCompleteOnboarding, didCompleteOnboarding) || other.didCompleteOnboarding == didCompleteOnboarding)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn)&&(identical(other.isRetrying, isRetrying) || other.isRetrying == isRetrying));
}


@override
int get hashCode => Object.hash(runtimeType,didCompleteOnboarding,isLoggedIn,isRetrying);

@override
String toString() {
  return 'StartupState.completed(didCompleteOnboarding: $didCompleteOnboarding, isLoggedIn: $isLoggedIn, isRetrying: $isRetrying)';
}


}

/// @nodoc
abstract mixin class $StartupCompletedCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory $StartupCompletedCopyWith(StartupCompleted value, $Res Function(StartupCompleted) _then) = _$StartupCompletedCopyWithImpl;
@override @useResult
$Res call({
 bool didCompleteOnboarding, bool isLoggedIn, bool isRetrying
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
@override @pragma('vm:prefer-inline') $Res call({Object? didCompleteOnboarding = null,Object? isLoggedIn = null,Object? isRetrying = null,}) {
  return _then(StartupCompleted(
didCompleteOnboarding: null == didCompleteOnboarding ? _self.didCompleteOnboarding : didCompleteOnboarding // ignore: cast_nullable_to_non_nullable
as bool,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,isRetrying: null == isRetrying ? _self.isRetrying : isRetrying // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
