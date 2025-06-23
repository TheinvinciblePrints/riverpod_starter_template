import 'package:flutter_riverpod_starter_template/src/enums/view_state.dart';
import 'package:flutter_riverpod_starter_template/src/shared/base/base_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/article_model.dart';

part 'news_state.freezed.dart';

// News state to keep track of loading, error, and data
@Freezed(unionKey: 'status', fallbackUnion: 'initial')
abstract class NewsState with _$NewsState {
  const NewsState._();

  // Factory constructor that implements BaseState
  @Implements<BaseState>()
  const factory NewsState.initial({
    @Default([]) List<ArticleModel> articles,
    @Default(ViewState.initial) ViewState viewState,
    String? errorMessage,
  }) = _NewsInitial;

  @Implements<BaseState>()
  const factory NewsState.loading({
    @Default([]) List<ArticleModel> articles,
    @Default(ViewState.loading) ViewState viewState,
    String? errorMessage,
  }) = _NewsLoading;

  @Implements<BaseState>()
  const factory NewsState.success({
    required List<ArticleModel> articles,
    @Default(ViewState.success) ViewState viewState,
    String? errorMessage,
  }) = _NewsSuccess;

  @Implements<BaseState>()
  const factory NewsState.error({
    required String errorMessage,
    @Default([]) List<ArticleModel> articles,
    @Default(ViewState.failure) ViewState viewState,
  }) = _NewsError;
}
