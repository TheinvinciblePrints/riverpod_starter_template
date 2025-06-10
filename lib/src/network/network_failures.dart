/// An abstract base class representing a generic NetworkFailure or error that can occur
/// during network operations or other processes.
///
/// Extend this class to define specific types of NetworkFailures, allowing for
/// consistent error handling throughout the application.
abstract class NetworkFailure {
  NetworkFailure({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  String get detailedMessage;

  /// returning current class name as error type
  String get errorType => runtimeType.toString();
}

class RequestCancelledNetworkFailure extends NetworkFailure {
  RequestCancelledNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class UnauthorisedRequestNetworkFailure extends NetworkFailure {
  UnauthorisedRequestNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class BadRequestNetworkFailure extends NetworkFailure {
  BadRequestNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class NotFoundNetworkFailure extends NetworkFailure {
  NotFoundNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class MethodNotAllowedNetworkFailure extends NetworkFailure {
  MethodNotAllowedNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class NotAcceptableNetworkFailure extends NetworkFailure {
  NotAcceptableNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class RequestTimeoutNetworkFailure extends NetworkFailure {
  RequestTimeoutNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class SendTimeoutNetworkFailure extends NetworkFailure {
  SendTimeoutNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class ConflictNetworkFailure extends NetworkFailure {
  ConflictNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class InternalServerErrorNetworkFailure extends NetworkFailure {
  InternalServerErrorNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class NotImplementedNetworkFailure extends NetworkFailure {
  NotImplementedNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class ServiceUnavailableNetworkFailure extends NetworkFailure {
  ServiceUnavailableNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class NoInternetConnectionNetworkFailure extends NetworkFailure {
  NoInternetConnectionNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class FormatExceptionNetworkFailure extends NetworkFailure {
  FormatExceptionNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class UnableToProcessNetworkFailure extends NetworkFailure {
  UnableToProcessNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class DefaultErrorNetworkFailure extends NetworkFailure {
  DefaultErrorNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class UnexpectedErrorNetworkFailure extends NetworkFailure {
  UnexpectedErrorNetworkFailure({required super.message, super.statusCode});
  @override
  String get detailedMessage => message;
}

class CustomNetworkFailure extends NetworkFailure {
  CustomNetworkFailure({required super.message, super.statusCode});

  @override
  String get detailedMessage => message;
}
