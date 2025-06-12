import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod_starter_template/generated/locale_keys.g.dart';

sealed class NetworkExceptions {
  const NetworkExceptions();

  factory NetworkExceptions.requestCancelled() = RequestCancelled;
  factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;
  factory NetworkExceptions.badRequest() = BadRequest;
  factory NetworkExceptions.notFound() = NotFound;
  factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  factory NetworkExceptions.notAcceptable() = NotAcceptable;
  factory NetworkExceptions.requestTimeout() = RequestTimeout;
  factory NetworkExceptions.sendTimeout() = SendTimeout;
  factory NetworkExceptions.conflict() = Conflict;
  factory NetworkExceptions.internalServerError() = InternalServerError;
  factory NetworkExceptions.notImplemented() = NotImplemented;
  factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  factory NetworkExceptions.formatException() = FormatException;
  factory NetworkExceptions.unableToProcess() = UnableToProcess;
  factory NetworkExceptions.defaultError() = DefaultError;
  factory NetworkExceptions.unexpectedError() = UnexpectedError;

  /// Returns a user-friendly error message based on the type of NetworkExceptions
  /// This method uses pattern matching to determine the specific type of error
  /// and returns the corresponding localized error message.
  static String getErrorMessage(NetworkExceptions networkExceptions) {
    return networkExceptions.when(
      notImplemented: () => LocaleKeys.notImplemented,
      requestCancelled: () => LocaleKeys.requestCancelled,
      internalServerError: () => LocaleKeys.internalServerError,
      notFound: () => LocaleKeys.notFound,
      serviceUnavailable: () => LocaleKeys.serviceUnavailable,
      methodNotAllowed: () => LocaleKeys.methodNotAllowed,
      badRequest: () => LocaleKeys.badRequest,
      unauthorisedRequest: () => LocaleKeys.unauthorisedRequest,
      unexpectedError: () => LocaleKeys.unexpectedError,
      requestTimeout: () => LocaleKeys.requestTimeout,
      noInternetConnection: () => LocaleKeys.noInternetConnection,
      conflict: () => LocaleKeys.conflict,
      sendTimeout: () => LocaleKeys.sendTimeout,
      unableToProcess: () => LocaleKeys.unableToProcess,
      defaultError: () => LocaleKeys.defaultError,
      formatException: () => LocaleKeys.formatException,
      notAcceptable: () => LocaleKeys.notAcceptable,
    );
  }

  /// Converts a DioException or other exceptions into NetworkExceptions
  static NetworkExceptions getDioException(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return NetworkExceptions.requestCancelled();
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.sendTimeout:
              return NetworkExceptions.requestTimeout();
            case DioExceptionType.connectionError:
              return NetworkExceptions.noInternetConnection();
            case DioExceptionType.badResponse:
              final statusCode = error.response?.statusCode ?? 0;
              return switch (statusCode) {
                400 || 401 || 403 => NetworkExceptions.unauthorisedRequest(),
                404 => NetworkExceptions.notFound(),
                409 => NetworkExceptions.conflict(),
                408 => NetworkExceptions.requestTimeout(),
                500 => NetworkExceptions.internalServerError(),
                503 => NetworkExceptions.serviceUnavailable(),
                _ => NetworkExceptions.defaultError(),
              };
            default:
              return NetworkExceptions.unexpectedError();
          }
        } else if (error is SocketException) {
          return NetworkExceptions.noInternetConnection();
        } else if (error is FormatException) {
          return NetworkExceptions.formatException();
        } else {
          return NetworkExceptions.unexpectedError();
        }
      } catch (_) {
        return NetworkExceptions.unexpectedError();
      }
    } else {
      return error.toString().contains("is not a subtype of")
          ? NetworkExceptions.unableToProcess()
          : NetworkExceptions.unexpectedError();
    }
  }

  /// `when` method for structured pattern matching
  T when<T>({
    required T Function() notImplemented,
    required T Function() requestCancelled,
    required T Function() internalServerError,
    required T Function() notFound,
    required T Function() serviceUnavailable,
    required T Function() methodNotAllowed,
    required T Function() badRequest,
    required T Function() unauthorisedRequest,
    required T Function() unexpectedError,
    required T Function() requestTimeout,
    required T Function() noInternetConnection,
    required T Function() conflict,
    required T Function() sendTimeout,
    required T Function() unableToProcess,
    required T Function() defaultError,
    required T Function() formatException,
    required T Function() notAcceptable,
  }) {
    return switch (this) {
      NotImplemented() => notImplemented(),
      RequestCancelled() => requestCancelled(),
      InternalServerError() => internalServerError(),
      NotFound() => notFound(),
      ServiceUnavailable() => serviceUnavailable(),
      MethodNotAllowed() => methodNotAllowed(),
      BadRequest() => badRequest(),
      UnauthorisedRequest() => unauthorisedRequest(),
      UnexpectedError() => unexpectedError(),
      RequestTimeout() => requestTimeout(),
      NoInternetConnection() => noInternetConnection(),
      Conflict() => conflict(),
      SendTimeout() => sendTimeout(),
      UnableToProcess() => unableToProcess(),
      DefaultError() => defaultError(),
      FormatException() => formatException(),
      NotAcceptable() => notAcceptable(),
    };
  }
}

/// Individual error types
class RequestCancelled extends NetworkExceptions {}

class UnauthorisedRequest extends NetworkExceptions {}

class BadRequest extends NetworkExceptions {}

class NotFound extends NetworkExceptions {}

class MethodNotAllowed extends NetworkExceptions {}

class NotAcceptable extends NetworkExceptions {}

class RequestTimeout extends NetworkExceptions {}

class SendTimeout extends NetworkExceptions {}

class Conflict extends NetworkExceptions {}

class InternalServerError extends NetworkExceptions {}

class NotImplemented extends NetworkExceptions {}

class ServiceUnavailable extends NetworkExceptions {}

class NoInternetConnection extends NetworkExceptions {}

class FormatException extends NetworkExceptions {}

class UnableToProcess extends NetworkExceptions {}

class DefaultError extends NetworkExceptions {}

class UnexpectedError extends NetworkExceptions {}
