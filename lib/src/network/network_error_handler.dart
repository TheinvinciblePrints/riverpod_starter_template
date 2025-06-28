import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod_starter_template/src/localization/locale_keys.g.dart';
import 'package:flutter_riverpod_starter_template/src/utils/network_exception_utils.dart';

import 'network_exceptions.dart';
import 'network_failures.dart';

/// A mixin that provides utility methods for handling network-related errors.
///
/// Implement this mixin to add standardized error handling logic for network
/// requests, such as parsing error responses, mapping exceptions to user-friendly
/// messages, or logging network failures.
mixin NetworkErrorHandler {
  /// Maps a NetworkExceptions instance to its corresponding NetworkFailure subclass
  NetworkFailure mapNetworkExceptionToNetworkFailure(
    NetworkExceptions exception, {
    int? statusCode,
    String? errorMessage,
  }) {
    final message =
        errorMessage ?? NetworkExceptionUtils.getErrorMessage(exception);

    return switch (exception) {
      NotImplemented() => NotImplementedNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      RequestCancelled() => RequestCancelledNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      InternalServerError() => InternalServerErrorNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      NotFound() => NotFoundNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      ServiceUnavailable() => ServiceUnavailableNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      MethodNotAllowed() => MethodNotAllowedNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      BadRequest() => BadRequestNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      UnauthorisedRequest() => UnauthorisedRequestNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      UnexpectedError() => UnexpectedErrorNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      RequestTimeout() => RequestTimeoutNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      NoInternetConnection() => NoInternetConnectionNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      Conflict() => ConflictNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      SendTimeout() => SendTimeoutNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      UnableToProcess() => UnableToProcessNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      DefaultError() => DefaultErrorNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      FormatException() => FormatExceptionNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      NotAcceptable() => NotAcceptableNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      ForbiddenError() => ForbiddenErrorNetworkFailure(
        message: message,
        statusCode: statusCode,
      ),
      BadRequestError() => BadRequestNetworkFailure(
        message: message,
      ), // no statusCode
    };
  }

  /// Handles Dio or other errors and returns a NetworkFailure
  NetworkFailure handleDioError(DioException dioError, StackTrace stackTrace) {
    debugPrint('dioErrorStatusCode: ${dioError.response?.statusCode}');
    debugPrint('dioError: ${dioError.toString()}');
    debugPrint('stackTrace: $stackTrace');

    final exception = NetworkExceptionUtils.fromDioException(dioError);
    final statusCode = dioError.response?.statusCode;

    if (exception is ForbiddenError) {
      return ForbiddenErrorNetworkFailure(
        message: LocaleKeys.forbidden,
        statusCode: statusCode,
      );
    }
    if (exception is NotFound) {
      return NotFoundNetworkFailure(
        message: LocaleKeys.notFound,
        statusCode: statusCode,
      );
    }

    // Extract error message from the API response if available
    final errorMessage = parseApiErrorResponse(dioError.response);

    return mapNetworkExceptionToNetworkFailure(
      exception,
      statusCode: statusCode,
      errorMessage: errorMessage,
    );
  }

  /// Parses the error response from the API and extracts a meaningful error message.
  ///
  /// This method handles various API error response formats and attempts to extract
  /// the most relevant error message for the user. It gracefully handles different
  /// error formats that might be returned by different APIs.
  ///
  /// @param response The Dio Response object that may contain error data
  /// @return A user-friendly error message extracted from the response, or null if no message could be extracted
  String? parseApiErrorResponse(Response? response) {
    if (response == null || response.data == null) {
      return null;
    }

    try {
      dynamic data = response.data;

      // If data is a string, try to parse it as JSON first
      if (data is String) {
        try {
          data = json.decode(data);
        } catch (_) {
          // If it's not valid JSON, return the string directly
          return data;
        }
      }

      // Handle common error response formats
      if (data is Map<String, dynamic>) {
        // Try different common error message fields
        final possibleFields = [
          'message',
          'error',
          'errorMessage',
          'error_message',
          'error_description',
          'errorDescription',
          'detail',
          'details',
        ];

        // First check for direct error fields
        for (final field in possibleFields) {
          if (data[field] != null && data[field] is String) {
            return data[field];
          }
        }

        // Check for nested error structures
        if (data['errors'] != null) {
          final errors = data['errors'];

          // If it's a list of errors, return the first one
          if (errors is List && errors.isNotEmpty) {
            final firstError = errors.first;

            if (firstError is String) {
              return firstError;
            } else if (firstError is Map<String, dynamic>) {
              // Check for common field names in the first error
              for (final field in possibleFields) {
                if (firstError[field] != null) {
                  return firstError[field].toString();
                }
              }

              // Try to get the first field if none of the common ones exist
              if (firstError.isNotEmpty) {
                final firstKey = firstError.keys.first;
                return '$firstKey: ${firstError[firstKey]}';
              }
            }
          }

          // If it's an object with field-specific errors
          if (errors is Map<String, dynamic> && errors.isNotEmpty) {
            final firstErrorKey = errors.keys.first;
            final firstErrorValue = errors[firstErrorKey];

            if (firstErrorValue is List && firstErrorValue.isNotEmpty) {
              return '$firstErrorKey: ${firstErrorValue.first}';
            } else {
              return '$firstErrorKey: $firstErrorValue';
            }
          }
        }

        // Check for validation error structure
        if (data['validation'] != null) {
          final validation = data['validation'];
          if (validation is Map<String, dynamic> && validation.isNotEmpty) {
            final firstField = validation.keys.first;
            final errors = validation[firstField];
            if (errors is List && errors.isNotEmpty) {
              return '$firstField: ${errors.first}';
            }
            return '$firstField: ${validation[firstField]}';
          }
        }

        // Last resort: convert the whole object to string
        return json.encode(data);
      }

      // If data is a list, try to get the first meaningful message
      if (data is List && data.isNotEmpty) {
        final firstItem = data.first;
        if (firstItem is String) {
          return firstItem;
        } else if (firstItem is Map<String, dynamic> &&
            (firstItem.containsKey('message') ||
                firstItem.containsKey('error'))) {
          return firstItem['message'] ?? firstItem['error'];
        }
      }
    } catch (e) {
      debugPrint('Error parsing API error response: $e');
    }

    // Default to status message or a generic error
    return response.statusMessage ?? 'An error occurred';
  }

  NetworkFailure unHandledError(dynamic error, StackTrace? stackTrace) {
    debugPrint('Unhandled exception: $error\n$stackTrace');

    return UnexpectedErrorNetworkFailure(
      message: LocaleKeys.unexpectedError,
      statusCode: null,
    );
  }

  /// A utility method to handle any type of exception and convert it to a NetworkFailure
  NetworkFailure handleException(dynamic exception, StackTrace? stackTrace) {
    if (exception is DioException) {
      return handleDioError(exception, stackTrace ?? StackTrace.current);
    } else if (exception is NetworkExceptions) {
      return mapNetworkExceptionToNetworkFailure(exception);
    } else {
      return unHandledError(exception, stackTrace);
    }
  }

  /// A utility method to safely execute an API call and return an ApiResult
  Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (exception) {
      rethrow;
    }
  }
}
