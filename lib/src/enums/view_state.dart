/// Represents the various states a view can be in, such as loading, loaded, or error.
///
/// This enum is typically used to manage and track the UI state in a Flutter application,
/// allowing widgets to react accordingly based on the current state.
enum ViewState {
  /// The request has yet been submitted.
  initial,

  /// The request is in the process of being submitted.
  loading,

  /// The request has been submitted successfully.
  success,

  /// The request submission failed.
  failure,

  /// The request submission has been canceled.
  canceled,

  /// The request submission is for refresh.
  refresh,
}

enum ViewErrorType {
  primary, //main view error, user can't proceed, needs to navigate back

  secondary, // other types of error
}

/// Useful extensions on [ViewState]
extension ViewStateX on ViewState {
  /// Indicates whether the request has not yet been submitted.
  bool get isInitial => this == ViewState.initial;

  /// Indicates whether the request is in the process of being submitted.
  bool get isLoading => this == ViewState.loading;

  /// Indicates whether the request has been submitted successfully.
  bool get isSuccess => this == ViewState.success;

  /// Indicates whether the request submission failed.
  bool get isFailure => this == ViewState.failure;

  /// Indicates whether the request submission has been canceled.
  bool get isCanceled => this == ViewState.canceled;

  /// Indicates whether the request is isRefresh
  bool get isRefresh => this == ViewState.refresh;

  /// Indicates whether the request is either in progress or has been submitted
  /// successfully.
  ///
  /// This is useful for showing a loading indicator or disabling the submit
  /// button to prevent duplicate submissions.
  bool get isInProgressOrSuccess => isLoading || isSuccess || isRefresh;
}
