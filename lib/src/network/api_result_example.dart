// Example usage of the ApiResult sealed class with pattern matching

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod_starter_template/src/network/api_result_freezed.dart';
import 'package:flutter_riverpod_starter_template/src/network/network_failures.dart';

/// This is an example of how to use the ApiResult sealed class in your code
class ApiResultExample {
  void demonstrateApiResultUsage() {
    // Create a success result
    final successResult = ApiResult<String>.success(data: 'Hello world');

    // Create an error result with a specific NetworkFailure
    final errorResult = ApiResult<String>.error(
      error: BadRequestNetworkFailure(
        message: 'Invalid credentials',
        statusCode: 400,
      ),
    );

    // Using pattern matching with switch expressions
    _processResult(successResult);
    _processResult(errorResult);

    // Using helper methods from our implementation
    _printData(successResult.dataOrNull);
    _printData(errorResult.dataOrNull);

    // Transform data with mapData
    final ApiResult<int> transformed = successResult.mapData(
      (data) => data.length,
    );
    _processResult(transformed);

    // Check result type
    _handleByType(successResult);
    _handleByType(errorResult);
  }

  void _processResult(ApiResult<dynamic> result) {
    final response = switch (result) {
      Success(data: final data) => 'Success: $data',
      Error(error: final error) =>
        'Error: ${error.message} (${error.errorType})',
    };

    if (kDebugMode) {
      print(response);
    }
  }

  void _printData(dynamic data) {
    if (kDebugMode) {
      print('Data: $data');
    }
  }

  void _handleByType(ApiResult<dynamic> result) {
    if (result.isSuccess) {
      if (kDebugMode) {
        print('This is a success result');
      }
    }

    if (result.isError) {
      if (kDebugMode) {
        print('This is an error result');
      }
    }
  }
}
