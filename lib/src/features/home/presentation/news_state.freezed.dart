// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NewsState {

 List<ArticleModel> get articles; ViewState get viewState; String? get errorMessage;
/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsStateCopyWith<NewsState> get copyWith => _$NewsStateCopyWithImpl<NewsState>(this as NewsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsState&&const DeepCollectionEquality().equals(other.articles, articles)&&(identical(other.viewState, viewState) || other.viewState == viewState)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(articles),viewState,errorMessage);

@override
String toString() {
  return 'NewsState(articles: $articles, viewState: $viewState, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $NewsStateCopyWith<$Res>  {
  factory $NewsStateCopyWith(NewsState value, $Res Function(NewsState) _then) = _$NewsStateCopyWithImpl;
@useResult
$Res call({
 List<ArticleModel> articles, ViewState viewState, String errorMessage
});




}
/// @nodoc
class _$NewsStateCopyWithImpl<$Res>
    implements $NewsStateCopyWith<$Res> {
  _$NewsStateCopyWithImpl(this._self, this._then);

  final NewsState _self;
  final $Res Function(NewsState) _then;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? articles = null,Object? viewState = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
articles: null == articles ? _self.articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,viewState: null == viewState ? _self.viewState : viewState // ignore: cast_nullable_to_non_nullable
as ViewState,errorMessage: null == errorMessage ? _self.errorMessage! : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc


class _NewsInitial extends NewsState implements BaseState {
  const _NewsInitial({final  List<ArticleModel> articles = const [], this.viewState = ViewState.initial, this.errorMessage}): _articles = articles,super._();
  

 final  List<ArticleModel> _articles;
@override@JsonKey() List<ArticleModel> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@override@JsonKey() final  ViewState viewState;
@override final  String? errorMessage;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsInitialCopyWith<_NewsInitial> get copyWith => __$NewsInitialCopyWithImpl<_NewsInitial>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsInitial&&const DeepCollectionEquality().equals(other._articles, _articles)&&(identical(other.viewState, viewState) || other.viewState == viewState)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles),viewState,errorMessage);

@override
String toString() {
  return 'NewsState.initial(articles: $articles, viewState: $viewState, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NewsInitialCopyWith<$Res> implements $NewsStateCopyWith<$Res> {
  factory _$NewsInitialCopyWith(_NewsInitial value, $Res Function(_NewsInitial) _then) = __$NewsInitialCopyWithImpl;
@override @useResult
$Res call({
 List<ArticleModel> articles, ViewState viewState, String? errorMessage
});




}
/// @nodoc
class __$NewsInitialCopyWithImpl<$Res>
    implements _$NewsInitialCopyWith<$Res> {
  __$NewsInitialCopyWithImpl(this._self, this._then);

  final _NewsInitial _self;
  final $Res Function(_NewsInitial) _then;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? articles = null,Object? viewState = null,Object? errorMessage = freezed,}) {
  return _then(_NewsInitial(
articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,viewState: null == viewState ? _self.viewState : viewState // ignore: cast_nullable_to_non_nullable
as ViewState,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _NewsLoading extends NewsState implements BaseState {
  const _NewsLoading({final  List<ArticleModel> articles = const [], this.viewState = ViewState.loading, this.errorMessage}): _articles = articles,super._();
  

 final  List<ArticleModel> _articles;
@override@JsonKey() List<ArticleModel> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@override@JsonKey() final  ViewState viewState;
@override final  String? errorMessage;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsLoadingCopyWith<_NewsLoading> get copyWith => __$NewsLoadingCopyWithImpl<_NewsLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsLoading&&const DeepCollectionEquality().equals(other._articles, _articles)&&(identical(other.viewState, viewState) || other.viewState == viewState)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles),viewState,errorMessage);

@override
String toString() {
  return 'NewsState.loading(articles: $articles, viewState: $viewState, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NewsLoadingCopyWith<$Res> implements $NewsStateCopyWith<$Res> {
  factory _$NewsLoadingCopyWith(_NewsLoading value, $Res Function(_NewsLoading) _then) = __$NewsLoadingCopyWithImpl;
@override @useResult
$Res call({
 List<ArticleModel> articles, ViewState viewState, String? errorMessage
});




}
/// @nodoc
class __$NewsLoadingCopyWithImpl<$Res>
    implements _$NewsLoadingCopyWith<$Res> {
  __$NewsLoadingCopyWithImpl(this._self, this._then);

  final _NewsLoading _self;
  final $Res Function(_NewsLoading) _then;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? articles = null,Object? viewState = null,Object? errorMessage = freezed,}) {
  return _then(_NewsLoading(
articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,viewState: null == viewState ? _self.viewState : viewState // ignore: cast_nullable_to_non_nullable
as ViewState,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _NewsSuccess extends NewsState implements BaseState {
  const _NewsSuccess({required final  List<ArticleModel> articles, this.viewState = ViewState.success, this.errorMessage}): _articles = articles,super._();
  

 final  List<ArticleModel> _articles;
@override List<ArticleModel> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@override@JsonKey() final  ViewState viewState;
@override final  String? errorMessage;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsSuccessCopyWith<_NewsSuccess> get copyWith => __$NewsSuccessCopyWithImpl<_NewsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsSuccess&&const DeepCollectionEquality().equals(other._articles, _articles)&&(identical(other.viewState, viewState) || other.viewState == viewState)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_articles),viewState,errorMessage);

@override
String toString() {
  return 'NewsState.success(articles: $articles, viewState: $viewState, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$NewsSuccessCopyWith<$Res> implements $NewsStateCopyWith<$Res> {
  factory _$NewsSuccessCopyWith(_NewsSuccess value, $Res Function(_NewsSuccess) _then) = __$NewsSuccessCopyWithImpl;
@override @useResult
$Res call({
 List<ArticleModel> articles, ViewState viewState, String? errorMessage
});




}
/// @nodoc
class __$NewsSuccessCopyWithImpl<$Res>
    implements _$NewsSuccessCopyWith<$Res> {
  __$NewsSuccessCopyWithImpl(this._self, this._then);

  final _NewsSuccess _self;
  final $Res Function(_NewsSuccess) _then;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? articles = null,Object? viewState = null,Object? errorMessage = freezed,}) {
  return _then(_NewsSuccess(
articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,viewState: null == viewState ? _self.viewState : viewState // ignore: cast_nullable_to_non_nullable
as ViewState,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _NewsError extends NewsState implements BaseState {
  const _NewsError({required this.errorMessage, final  List<ArticleModel> articles = const [], this.viewState = ViewState.failure}): _articles = articles,super._();
  

@override final  String errorMessage;
 final  List<ArticleModel> _articles;
@override@JsonKey() List<ArticleModel> get articles {
  if (_articles is EqualUnmodifiableListView) return _articles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_articles);
}

@override@JsonKey() final  ViewState viewState;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsErrorCopyWith<_NewsError> get copyWith => __$NewsErrorCopyWithImpl<_NewsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._articles, _articles)&&(identical(other.viewState, viewState) || other.viewState == viewState));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage,const DeepCollectionEquality().hash(_articles),viewState);

@override
String toString() {
  return 'NewsState.error(errorMessage: $errorMessage, articles: $articles, viewState: $viewState)';
}


}

/// @nodoc
abstract mixin class _$NewsErrorCopyWith<$Res> implements $NewsStateCopyWith<$Res> {
  factory _$NewsErrorCopyWith(_NewsError value, $Res Function(_NewsError) _then) = __$NewsErrorCopyWithImpl;
@override @useResult
$Res call({
 String errorMessage, List<ArticleModel> articles, ViewState viewState
});




}
/// @nodoc
class __$NewsErrorCopyWithImpl<$Res>
    implements _$NewsErrorCopyWith<$Res> {
  __$NewsErrorCopyWithImpl(this._self, this._then);

  final _NewsError _self;
  final $Res Function(_NewsError) _then;

/// Create a copy of NewsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,Object? articles = null,Object? viewState = null,}) {
  return _then(_NewsError(
errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,articles: null == articles ? _self._articles : articles // ignore: cast_nullable_to_non_nullable
as List<ArticleModel>,viewState: null == viewState ? _self.viewState : viewState // ignore: cast_nullable_to_non_nullable
as ViewState,
  ));
}


}

// dart format on
