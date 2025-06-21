# Testing the AuthRepository

The new implementation of `login()` in AuthRepository is highly testable. Here's why:

## 1. Predictable Flow

The function now has a predictable flow where it directly returns `ApiResult` instances rather than throwing exceptions. This makes it easier to test both success and error paths.

## 2. Easy to Mock

Since the function returns `ApiResult` objects directly, it's easy to mock the behavior in tests:

```dart
// Mock implementation for testing
class MockAuthRepository implements AuthRepository {
  // Test the success case
  @override
  Future<ApiResult<User>> login({required LoginRequest request}) async {
    // For testing success:
    if (request.username == 'test_success') {
      return ApiResult.success(
        data: User(
          id: 1,
          username: 'test_success',
          email: 'test@example.com',
          firstName: 'Test',
          lastName: 'User',
          accessToken: 'mock-token',
        ),
      );
    }
    // For testing empty data:
    else if (request.username == 'test_empty_data') {
      return ApiResult.error(
        error: CustomNetworkFailure(
          message: 'Failed to login: Empty response',
          statusCode: 200,
        ),
      );
    }
    // For testing network error:
    else if (request.username == 'test_network_error') {
      return ApiResult.error(
        error: NoInternetConnectionNetworkFailure(
          message: 'No internet connection',
          statusCode: null,
        ),
      );
    }
    // Default error case
    else {
      return ApiResult.error(
        error: UnauthorisedRequestNetworkFailure(
          message: 'Invalid credentials',
          statusCode: 401,
        ),
      );
    }
  }

  @override
  Future<User?> getCurrentUser() async => null;

  @override
  Future<void> logout() async {}
}
```

## 3. Clear Test Cases

With this approach, you can write clear, focused tests:

```dart
void main() {
  late AuthRepository authRepository;
  
  setUp(() {
    // Use the mock implementation for tests
    authRepository = MockAuthRepository();
  });

  test('login returns success with valid credentials', () async {
    // Act
    final result = await authRepository.login(
      request: LoginRequest(username: 'test_success', password: 'test123'),
    );
    
    // Assert
    expect(result.isSuccess, true);
    expect(result.dataOrNull?.username, equals('test_success'));
    expect(result.dataOrNull?.accessToken, equals('mock-token'));
  });

  test('login handles empty response data', () async {
    // Act
    final result = await authRepository.login(
      request: LoginRequest(username: 'test_empty_data', password: 'test123'),
    );
    
    // Assert
    expect(result.isError, true);
    if (result is Error<User>) {
      expect(result.error.message, contains('Empty response'));
    }
  });

  test('login handles network errors', () async {
    // Act
    final result = await authRepository.login(
      request: LoginRequest(username: 'test_network_error', password: 'test123'),
    );
    
    // Assert
    expect(result.isError, true);
    if (result is Error<User>) {
      expect(result.error, isA<NoInternetConnectionNetworkFailure>());
    }
  });
}
```

## 4. Testing in Controllers

This approach also makes testing controllers easier:

```dart
class LoginController extends StateNotifier<LoginState> {
  final AuthRepository authRepository;
  
  LoginController(this.authRepository) : super(LoginState());
  
  Future<void> login({required String username, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    final result = await authRepository.login(
      request: LoginRequest(username: username, password: password),
    );
    
    state = switch (result) {
      Success(data: final user) => state.copyWith(
          isLoading: false, 
          user: user,
        ),
      Error(error: final error) => state.copyWith(
          isLoading: false,
          errorMessage: error.message,
        ),
    };
  }
}

// Testing the controller becomes simple:
void testLoginController() {
  late LoginController controller;
  late MockAuthRepository mockRepo;
  
  setUp(() {
    mockRepo = MockAuthRepository();
    controller = LoginController(mockRepo);
  });
  
  test('controller sets user on successful login', () async {
    // Act
    await controller.login(username: 'test_success', password: 'password');
    
    // Assert
    expect(controller.state.isLoading, false);
    expect(controller.state.user?.username, equals('test_success'));
    expect(controller.state.errorMessage, isNull);
  });
  
  test('controller sets error message on login failure', () async {
    // Act
    await controller.login(username: 'test_wrong_credentials', password: 'password');
    
    // Assert
    expect(controller.state.isLoading, false);
    expect(controller.state.user, isNull);
    expect(controller.state.errorMessage, equals('Invalid credentials'));
  });
}
```

## 5. Benefits for Testing in General

- **No try/catch complexities**: Tests don't need to handle exceptions
- **Explicit assertions**: You can explicitly assert on success or failure cases
- **Full type safety**: The ApiResult generics ensure type safety
- **Pure functions**: The repository methods act as pure functions that return values rather than causing side effects
- **Pattern matching**: Dart 3's pattern matching makes handling the results elegant and readable
