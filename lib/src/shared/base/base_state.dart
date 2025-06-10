import '../../enums/view_state.dart';

abstract class BaseState {
  final ViewState viewState;
  final String? errorMessage;

  const BaseState({
    this.viewState = ViewState.initial,
    this.errorMessage,
  });
}