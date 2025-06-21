# Error Handling in Flutter Riverpod Starter Template

This document provides an overview of the robust error handling system implemented in this Flutter Riverpod starter template.

## Key Components

### 1. NetworkExceptions

`NetworkExceptions` is a sealed class hierarchy representing different types of network-related exceptions. It uses Dart 3's pattern matching capabilities to provide detailed error information.

### 2. NetworkFailure

`NetworkFailure` is an abstract class representing all types of failures that can occur during API calls. Each specific failure type extends this class and provides its own implementation of `detailedMessage`.

### 3. NetworkErrorHandler Mixin

The `NetworkErrorHandler` mixin provides utility methods for handling network-related errors:

- `mapNetworkExceptionToNetworkFailure`: Maps NetworkExceptions to NetworkFailure subclasses.
- `handleDioError`: Handles Dio errors and returns appropriate NetworkFailures.
- `parseApiErrorResponse`: Parses error responses from APIs to extract meaningful error messages.
- `unHandledError`: Handles unexpected errors and converts them to NetworkFailures.

### 4. ErrorHandler Class

The `ErrorHandler` class builds on top of the `NetworkErrorHandler` mixin, providing additional utility methods:

- `execute<T>`: Safely executes an API call and wraps the result in an ApiResult.
- `executeWithApiResult<T>`: Safely executes an API call that already returns an ApiResult.
- `error<T>`: Creates an ApiResult.error with the given message and status code.
- `isUnauthorized`: Checks if a failure is of unauthorized type.
- `isNetworkError`: Checks if a failure is due to network connectivity issues.
- `safeParse<T>`: Safely parses a response to extract data.
- `createErrorMessage`: Creates a user-friendly error message from a NetworkFailure.

### 5. ApiResult

`ApiResult<T>` is a freezed sealed class representing the result of an API operation:

- `ApiResult.success`: Represents a successful operation with data.
- `ApiResult.error`: Represents an error with a NetworkFailure.

It provides helper methods like `mapData`, `dataOrNull`, `isSuccess`, and `isError`.

## Usage Example

### Repository Layer

```dart
Future<ApiResult<User>> login({required LoginRequest request}) async {
  return _errorHandler.execute<User>(() async {
    final response = await _apiClient.post('/auth/login', body: request.toJson());
    final user = User.fromJson(response.data);
    return user;
  });
}
```

### Controller/Notifier Layer

```dart
Future<void> login({required String username, required String password}) async {
  state = state.copyWith(isLoading: true, errorMessage: null);

  final repository = await ref.read(authRepositoryProvider.future);
  final result = await _errorHandler.executeWithApiResult(() async {
    final loginRequest = LoginRequest(username: username, password: password);
    return await repository.login(request: loginRequest);
  });

  state = switch (result) {
    Success(data: final user) => state.copyWith(
        isLoading: false,
        user: user,
      ),
    Error(error: final error) => state.copyWith(
        isLoading: false,
        errorMessage: _errorHandler.createErrorMessage(error),
      ),
  };
}
```

## Best Practices

1. **Use pattern matching**: Leverage Dart 3's pattern matching for handling ApiResult.
2. **Centralize error handling**: Use the ErrorHandler class for all API calls.
3. **Extract meaningful error messages**: The parseApiErrorResponse method handles various API error formats.
4. **Type safety**: ApiResult uses generics to ensure type safety.
5. **User-friendly messages**: Convert technical errors to user-friendly messages.
