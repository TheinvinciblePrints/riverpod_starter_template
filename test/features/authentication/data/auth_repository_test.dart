import 'package:dio/dio.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod_starter_template/src/features/authentication/domain/login_request.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_client.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_result_freezed.dart';
import 'package:flutter_riverpod_starter_template/src/network/error_handler.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_failures.dart';
import 'package:flutter_riverpod_starter_template/src/storage/storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([IPreferenceStorage, ISecureStorage, ApiClient, ErrorHandler])
void main() {
  late MockIPreferenceStorage mockPreferenceStorage;
  late MockISecureStorage mockSecureStorage;
  late MockApiClient mockApiClient;
  late MockErrorHandler mockErrorHandler;
  late AuthRepositoryImpl authRepository;

  setUp(() {
    mockPreferenceStorage = MockIPreferenceStorage();
    mockSecureStorage = MockISecureStorage();
    mockApiClient = MockApiClient();
    mockErrorHandler = MockErrorHandler();
    authRepository = AuthRepositoryImpl(
      mockPreferenceStorage,
      mockSecureStorage,
      mockApiClient,
      mockErrorHandler,
    );
  });

  group('AuthRepository', () {
    final loginRequest = LoginRequest(username: 'test', password: 'password');
    final mockResponse = Response(
      requestOptions: RequestOptions(path: ''),
      data: {
        'id': 1,
        'username': 'test',
        'email': 'test@example.com',
        'firstName': 'Test',
        'lastName': 'User',
        'gender': 'male',
        'accessToken': 'mock-token',
        'refreshToken': 'mock-refresh-token',
        'image': 'https://example.com/image.png',
      },
      statusCode: 200,
    );

    test('login - success case', () async {
      // Arrange
      when(
        mockApiClient.post(any, body: anyNamed('body')),
      ).thenAnswer((_) async => mockResponse);

      when(
        mockSecureStorage.saveAccessToken(any),
      ).thenAnswer((_) async => true);
      when(mockPreferenceStorage.saveUser(any)).thenAnswer((_) async => true);

      // Act
      final result = await authRepository.login(request: loginRequest);

      // Assert
      expect(result, isA<Success<User>>());
      expect((result as Success).data.username, equals('test'));

      // Verify tokens and user were saved
      verify(mockSecureStorage.saveAccessToken('mock-token')).called(1);
      verify(mockPreferenceStorage.saveUser(any)).called(1);
    });

    test('login - handles null response data', () async {
      // Arrange
      when(mockApiClient.post(any, body: anyNamed('body'))).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: ''),
          data: null, // Null data
          statusCode: 200,
        ),
      );

      when(
        mockErrorHandler.error<User>(
          message: anyNamed('message'),
          statusCode: anyNamed('statusCode'),
        ),
      ).thenReturn(
        ApiResult<User>.error(
          error: CustomNetworkFailure(
            message: 'Failed to login: Empty response',
            statusCode: 200,
          ),
        ),
      );

      // Act
      final result = await authRepository.login(request: loginRequest);

      // Assert
      expect(result, isA<Error<User>>());
      expect((result as Error).error.message, contains('Empty response'));

      // Verify tokens were not saved
      verifyNever(mockSecureStorage.saveAccessToken(any));
      verifyNever(mockPreferenceStorage.saveUser(any));
    });

    test('login - handles exceptions', () async {
      // Arrange
      when(mockApiClient.post(any, body: anyNamed('body'))).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Network error',
          type: DioExceptionType.connectionError,
        ),
      );

      when(mockErrorHandler.handleException(any, any)).thenReturn(
        NoInternetConnectionNetworkFailure(
          message: 'No internet connection',
          statusCode: null,
        ),
      );

      // Act
      final result = await authRepository.login(request: loginRequest);

      // Assert
      expect(result, isA<Error<User>>());
      expect(
        (result as Error).error.message,
        contains('No internet connection'),
      );

      // Verify tokens were not saved
      verifyNever(mockSecureStorage.saveAccessToken(any));
      verifyNever(mockPreferenceStorage.saveUser(any));
    });
  });
}
