import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_result_freezed.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_error_handler.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_exception.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_failures.dart';

/// A comprehensive error handler utility class for handling API errors and exceptions.
///
/// This class provides methods to safely execute API calls, handle exceptions,
/// and convert them into appropriate [NetworkFailure] objects or [ApiResult.error] instances.
class ErrorHandler with NetworkErrorHandler {
  static final ErrorHandler _instance = ErrorHandler._internal();

  /// Private constructor
  ErrorHandler._internal();

  /// Returns a singleton instance of ErrorHandler
  factory ErrorHandler() => _instance;

  /// Safely executes an API call and wraps the result in an ApiResult.
  ///
  /// This method catches any exceptions that occur during the API call and
  /// converts them to appropriate NetworkFailure objects within ApiResult.error.
  Future<ApiResult<T>> execute<T>(Future<T> Function() apiCall) async {
    try {
      final result = await apiCall();
      return ApiResult.success(data: result);
    } catch (e, stackTrace) {
      debugPrint('Error executing API call: $e');
      debugPrint('Stack trace: $stackTrace');

      NetworkFailure failure;

      if (e is DioException) {
        failure = handleDioError(e, stackTrace);
      } else if (e is NetworkExceptions) {
        failure = mapNetworkExceptionToNetworkFailure(e);
      } else {
        failure = unHandledError(e, stackTrace);
      }

      return ApiResult.error(error: failure);
    }
  }

  /// Safely executes an API call where the result is already an ApiResult.
  ///
  /// This method is useful when calling repository methods that already return ApiResult,
  /// but you still want to catch any unexpected exceptions.
  Future<ApiResult<T>> executeWithApiResult<T>(
    Future<ApiResult<T>> Function() apiCall,
  ) async {
    try {
      return await apiCall();
    } catch (e, stackTrace) {
      debugPrint('Error executing API call with ApiResult: $e');
      debugPrint('Stack trace: $stackTrace');

      NetworkFailure failure;

      if (e is DioException) {
        failure = handleDioError(e, stackTrace);
      } else if (e is NetworkExceptions) {
        failure = mapNetworkExceptionToNetworkFailure(e);
      } else {
        failure = unHandledError(e, stackTrace);
      }

      return ApiResult.error(error: failure);
    }
  }

  /// Returns an ApiResult.error with the given message and status code
  ApiResult<T> error<T>({required String message, int? statusCode}) {
    return ApiResult<T>.error(
      error: CustomNetworkFailure(message: message, statusCode: statusCode),
    );
  }

  /// Checks if a failure is of unauthorized type (401)
  bool isUnauthorized(NetworkFailure failure) {
    return failure is UnauthorisedRequestNetworkFailure ||
        failure.statusCode == 401;
  }

  /// Checks if a failure is due to network connectivity issues
  bool isNetworkError(NetworkFailure failure) {
    return failure is NoInternetConnectionNetworkFailure;
  }

  /// Safely parses a response to extract data
  /// Returns null if parsing fails
  T? safeParse<T>(
    Response? response,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (response == null || response.data == null) {
      return null;
    }

    try {
      if (response.data is Map<String, dynamic>) {
        return fromJson(response.data as Map<String, dynamic>);
      } else {
        debugPrint(
          'Response data is not a Map<String, dynamic>: ${response.data}',
        );
        return null;
      }
    } catch (e, stackTrace) {
      debugPrint('Error parsing response data: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }

  /// Creates a user-friendly error message from a NetworkFailure
  String createErrorMessage(NetworkFailure failure) {
    if (isNetworkError(failure)) {
      return 'Please check your internet connection and try again.';
    } else if (isUnauthorized(failure)) {
      return 'Your session has expired. Please log in again.';
    } else {
      return failure.message;
    }
  }
}
