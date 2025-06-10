import 'network_failures.dart';

/// Utility class to wrap result data
sealed class ApiResult<T> {
  const ApiResult();

  /// Creates a successful [ApiResult], completed with the specified [data].
  const factory ApiResult.success({required T data}) = Success._;

  /// Creates an error [ApiResult], completed with the specified [error].
  const factory ApiResult.error({required NetworkFailure error}) = Error._;

  /// Pattern matching method
  R when<R>({
    required R Function(T value) onSuccess,
    required R Function(NetworkFailure error) onError,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else if (this is Error<T>) {
      return onError((this as Error<T>).error);
    }
    throw DefaultErrorNetworkFailure(message: 'Unhandled Result type');
  }
}

/// Subclass of Result for values
final class Success<T> extends ApiResult<T> {
  const Success._({required this.data});

  /// Returned value in result
  final T data;

  @override
  String toString() => 'Result<$T>.ok($data)';
}

/// Subclass of Result for errors
final class Error<T> extends ApiResult<T> {
  const Error._({required this.error});

  /// Returned error in result
  final NetworkFailure error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
