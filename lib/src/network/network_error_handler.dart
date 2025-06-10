import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'network_exception.dart';
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
  }) {
    return exception.when(
      notImplemented:
          () => NotImplementedNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      requestCancelled:
          () => RequestCancelledNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      internalServerError:
          () => InternalServerErrorNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      notFound:
          () => NotFoundNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      serviceUnavailable:
          () => ServiceUnavailableNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      methodNotAllowed:
          () => MethodNotAllowedNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      badRequest:
          () => BadRequestNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      unauthorisedRequest:
          () => UnauthorisedRequestNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      unexpectedError:
          () => UnexpectedErrorNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      requestTimeout:
          () => RequestTimeoutNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      noInternetConnection:
          () => NoInternetConnectionNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      conflict:
          () => ConflictNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      sendTimeout:
          () => SendTimeoutNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      unableToProcess:
          () => UnableToProcessNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      defaultError:
          () => DefaultErrorNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      formatException:
          () => FormatExceptionNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
      notAcceptable:
          () => NotAcceptableNetworkFailure(
            message: NetworkExceptions.getErrorMessage(exception),
            statusCode: statusCode,
          ),
    );
  }

  /// Handles Dio or other errors and returns a NetworkFailure
  NetworkFailure handleDioError(DioException dioError, StackTrace stackTrace) {
    debugPrint('dioErrorStatusCode: \\${dioError.response?.statusCode}');
    debugPrint('dioError: \\${dioError.toString()}');
    debugPrint('stackTrace: $stackTrace');

    final exception = NetworkExceptions.getDioException(dioError);
    final statusCode = dioError.response?.statusCode;
    return mapNetworkExceptionToNetworkFailure(
      exception,
      statusCode: statusCode,
    );
  }

  NetworkFailure unHandledError(String error, StackTrace? stackTrace) {
    debugPrint('Unhandled exception: $error\\n$stackTrace');
    return UnexpectedErrorNetworkFailure(message: error, statusCode: null);
  }
}
