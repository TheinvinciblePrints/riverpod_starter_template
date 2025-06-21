import 'package:flutter_riverpod_starter_template/src/network/network_failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result_freezed.freezed.dart';

/// Represents the result of an API operation, which can be either successful with data
/// or an error with failure details.
@freezed
sealed class ApiResult<T> with _$ApiResult<T> {
  const ApiResult._();

  /// Creates a successful [ApiResult], completed with the specified [data].
  const factory ApiResult.success({required T data}) = Success<T>;

  /// Creates an error [ApiResult], completed with the specified [error].
  const factory ApiResult.error({required NetworkFailure error}) = Error<T>;

  /// Maps this [ApiResult] to a new [ApiResult] with a new data type.
  ApiResult<R> mapData<R>(R Function(T) mapper) {
    return switch (this) {
      Success(data: final data) => ApiResult.success(data: mapper(data)),
      Error(error: final error) => ApiResult.error(error: error),
    };
  }

  /// Returns the data if this is a [Success], otherwise returns null.
  T? get dataOrNull {
    return switch (this) {
      Success(data: final data) => data,
      Error() => null,
    };
  }

  /// Returns true if this result is a [Success].
  bool get isSuccess => this is Success<T>;

  /// Returns true if this result is an [Error].
  bool get isError => this is Error<T>;
}
