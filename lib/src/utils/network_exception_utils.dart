import 'dart:io';


import 'package:dio/dio.dart';
import 'package:flutter_riverpod_starter_template/src/localization/locale_keys.g.dart';
import 'package:flutter_riverpod_starter_template/src/network/network.dart';

class NetworkExceptionUtils {
  static String getErrorMessage(NetworkExceptions exception) {
    return switch (exception) {
      RequestCancelled() => LocaleKeys.requestCancelled,
      UnauthorisedRequest() => LocaleKeys.unauthorisedRequest,
      BadRequest() => LocaleKeys.badRequest,
      NotFound() => LocaleKeys.notFound,
      MethodNotAllowed() => LocaleKeys.methodNotAllowed,
      NotAcceptable() => LocaleKeys.notAcceptable,
      RequestTimeout() => LocaleKeys.requestTimeout,
      SendTimeout() => LocaleKeys.sendTimeout,
      Conflict() => LocaleKeys.conflict,
      InternalServerError() => LocaleKeys.internalServerError,
      NotImplemented() => LocaleKeys.notImplemented,
      ServiceUnavailable() => LocaleKeys.serviceUnavailable,
      NoInternetConnection() => LocaleKeys.noInternetConnection,
      FormatException() => LocaleKeys.formatException,
      UnableToProcess() => LocaleKeys.unableToProcess,
      DefaultError() => LocaleKeys.defaultError,
      UnexpectedError() => LocaleKeys.unexpectedError,
      BadRequestError() => LocaleKeys.badRequest,
      ForbiddenError() => LocaleKeys.forbidden,
    };
  }

  static NetworkExceptions fromDioException(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              return const NetworkExceptions.requestCancelled();
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.receiveTimeout:
            case DioExceptionType.sendTimeout:
              return const NetworkExceptions.requestTimeout();
            case DioExceptionType.connectionError:
              return const NetworkExceptions.noInternetConnection();
            case DioExceptionType.badResponse:
              final statusCode = error.response?.statusCode ?? 0;
              return switch (statusCode) {
                400 => const NetworkExceptions.badRequest(),
                401 => const NetworkExceptions.unauthorisedRequest(),
                403 => const NetworkExceptions.forbiddenError(),
                404 => const NetworkExceptions.notFound(),
                409 => const NetworkExceptions.conflict(),
                408 => const NetworkExceptions.requestTimeout(),
                500 => const NetworkExceptions.internalServerError(),
                503 => const NetworkExceptions.serviceUnavailable(),
                _ => const NetworkExceptions.defaultError(),
              };
            default:
              return const NetworkExceptions.unexpectedError();
          }
        } else if (error is SocketException) {
          return const NetworkExceptions.noInternetConnection();
        } else if (error is FormatException) {
          return const NetworkExceptions.formatException();
        } else {
          return const NetworkExceptions.unexpectedError();
        }
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      return error.toString().contains('is not a subtype of')
          ? const NetworkExceptions.unableToProcess()
          : const NetworkExceptions.unexpectedError();
    }
  }
}
