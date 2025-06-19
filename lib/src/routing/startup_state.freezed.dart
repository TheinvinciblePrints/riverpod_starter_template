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

 bool get isLoading; bool get hasError; String? get errorMessage; Object? get errorObject; bool get didCompleteOnboarding; bool get isLoggedIn;
/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupStateCopyWith<StartupState> get copyWith => _$StartupStateCopyWithImpl<StartupState>(this as StartupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.errorObject, errorObject)&&(identical(other.didCompleteOnboarding, didCompleteOnboarding) || other.didCompleteOnboarding == didCompleteOnboarding)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,hasError,errorMessage,const DeepCollectionEquality().hash(errorObject),didCompleteOnboarding,isLoggedIn);

@override
String toString() {
  return 'StartupState(isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, errorObject: $errorObject, didCompleteOnboarding: $didCompleteOnboarding, isLoggedIn: $isLoggedIn)';
}


}

/// @nodoc
abstract mixin class $StartupStateCopyWith<$Res>  {
  factory $StartupStateCopyWith(StartupState value, $Res Function(StartupState) _then) = _$StartupStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool hasError, String? errorMessage, Object? errorObject, bool didCompleteOnboarding, bool isLoggedIn
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
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? hasError = null,Object? errorMessage = freezed,Object? errorObject = freezed,Object? didCompleteOnboarding = null,Object? isLoggedIn = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorObject: freezed == errorObject ? _self.errorObject : errorObject ,didCompleteOnboarding: null == didCompleteOnboarding ? _self.didCompleteOnboarding : didCompleteOnboarding // ignore: cast_nullable_to_non_nullable
as bool,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc


class _StartupState implements StartupState {
  const _StartupState({this.isLoading = true, this.hasError = false, this.errorMessage, this.errorObject, this.didCompleteOnboarding = false, this.isLoggedIn = false});
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool hasError;
@override final  String? errorMessage;
@override final  Object? errorObject;
@override@JsonKey() final  bool didCompleteOnboarding;
@override@JsonKey() final  bool isLoggedIn;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartupStateCopyWith<_StartupState> get copyWith => __$StartupStateCopyWithImpl<_StartupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartupState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.errorObject, errorObject)&&(identical(other.didCompleteOnboarding, didCompleteOnboarding) || other.didCompleteOnboarding == didCompleteOnboarding)&&(identical(other.isLoggedIn, isLoggedIn) || other.isLoggedIn == isLoggedIn));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,hasError,errorMessage,const DeepCollectionEquality().hash(errorObject),didCompleteOnboarding,isLoggedIn);

@override
String toString() {
  return 'StartupState(isLoading: $isLoading, hasError: $hasError, errorMessage: $errorMessage, errorObject: $errorObject, didCompleteOnboarding: $didCompleteOnboarding, isLoggedIn: $isLoggedIn)';
}


}

/// @nodoc
abstract mixin class _$StartupStateCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory _$StartupStateCopyWith(_StartupState value, $Res Function(_StartupState) _then) = __$StartupStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool hasError, String? errorMessage, Object? errorObject, bool didCompleteOnboarding, bool isLoggedIn
});




}
/// @nodoc
class __$StartupStateCopyWithImpl<$Res>
    implements _$StartupStateCopyWith<$Res> {
  __$StartupStateCopyWithImpl(this._self, this._then);

  final _StartupState _self;
  final $Res Function(_StartupState) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? hasError = null,Object? errorMessage = freezed,Object? errorObject = freezed,Object? didCompleteOnboarding = null,Object? isLoggedIn = null,}) {
  return _then(_StartupState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorObject: freezed == errorObject ? _self.errorObject : errorObject ,didCompleteOnboarding: null == didCompleteOnboarding ? _self.didCompleteOnboarding : didCompleteOnboarding // ignore: cast_nullable_to_non_nullable
as bool,isLoggedIn: null == isLoggedIn ? _self.isLoggedIn : isLoggedIn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
