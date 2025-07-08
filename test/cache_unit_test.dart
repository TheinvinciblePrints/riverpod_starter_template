import 'dart:convert';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cache Serialization Tests', () {
    test(
      'should properly serialize and deserialize cache response with correct types',
      () {
        // Create a mock cache response
        final originalResponse = CacheResponse(
          key: 'test_key',
          url: 'https://example.com/test',
          eTag: null,
          lastModified: null,
          maxStale: null,
          content: [1, 2, 3, 4, 5], // List<int>
          date: DateTime.now(),
          expires: DateTime.now().add(const Duration(hours: 1)),
          headers: [200, 304], // List<int>
          requestDate: DateTime.now(),
          responseDate: DateTime.now(),
          cacheControl: CacheControl(maxAge: 3600),
          priority: CachePriority.normal,
        );

        // Simulate the serialization process that happens in HivePersistentCacheStore.set()
        final cacheData = {
          'key': originalResponse.key,
          'url': originalResponse.url,
          'eTag': originalResponse.eTag,
          'lastModified': originalResponse.lastModified,
          'content': originalResponse.content,
          'date':
              originalResponse.date?.millisecondsSinceEpoch ??
              DateTime.now().millisecondsSinceEpoch,
          'expires': originalResponse.expires?.millisecondsSinceEpoch,
          'headers': originalResponse.headers,
          'priority': originalResponse.priority.index,
          'requestDate': originalResponse.requestDate.millisecondsSinceEpoch,
          'responseDate': originalResponse.responseDate.millisecondsSinceEpoch,
          'maxAge': originalResponse.cacheControl.maxAge,
          'maxStaleControl': originalResponse.cacheControl.maxStale,
        };

        // Serialize to JSON (like Hive does)
        final jsonString = jsonEncode(cacheData);

        // Deserialize from JSON (simulate what get() method does)
        final cachedData = jsonDecode(jsonString) as Map<String, dynamic>;

        // Test the fixed deserialization logic
        final deserializedResponse = CacheResponse(
          key: cachedData['key'] as String,
          url: cachedData['url'] as String,
          eTag: cachedData['eTag'] as String?,
          lastModified: cachedData['lastModified'] as String?,
          maxStale:
              cachedData['expires'] != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                    cachedData['expires'] as int,
                  )
                  : null,
          content: (cachedData['content'] as List).cast<int>(), // Fixed line
          date: DateTime.fromMillisecondsSinceEpoch(cachedData['date'] as int),
          expires:
              cachedData['expires'] != null
                  ? DateTime.fromMillisecondsSinceEpoch(
                    cachedData['expires'] as int,
                  )
                  : null,
          headers: (cachedData['headers'] as List?)?.cast<int>(),
          priority: CachePriority.values[cachedData['priority'] as int? ?? 0],
          requestDate: DateTime.fromMillisecondsSinceEpoch(
            cachedData['requestDate'] as int,
          ),
          responseDate: DateTime.fromMillisecondsSinceEpoch(
            cachedData['responseDate'] as int,
          ),
          cacheControl: CacheControl(
            maxAge: cachedData['maxAge'] as int? ?? 0,
            maxStale: cachedData['maxStaleControl'] as int? ?? 0,
          ),
        );

        // Verify that deserialization worked correctly
        expect(deserializedResponse.key, equals(originalResponse.key));
        expect(deserializedResponse.url, equals(originalResponse.url));
        expect(deserializedResponse.content, equals(originalResponse.content));
        expect(deserializedResponse.content, isA<List<int>>());
        expect(deserializedResponse.headers, equals(originalResponse.headers));
        expect(deserializedResponse.headers, isA<List<int>?>());
        expect(
          deserializedResponse.priority,
          equals(originalResponse.priority),
        );

        print('✅ Serialization/deserialization test passed!');
        print('✅ Content type: ${deserializedResponse.content.runtimeType}');
        print('✅ Headers type: ${deserializedResponse.headers.runtimeType}');
      },
    );

    test('should handle null content and headers correctly', () {
      // Test with null content and headers
      final cacheData = {
        'key': 'test_key_null',
        'url': 'https://example.com/null',
        'eTag': null,
        'lastModified': null,
        'content': null,
        'date': DateTime.now().millisecondsSinceEpoch,
        'expires': null,
        'headers': null,
        'priority': 0,
        'requestDate': DateTime.now().millisecondsSinceEpoch,
        'responseDate': DateTime.now().millisecondsSinceEpoch,
        'maxAge': 3600,
        'maxStaleControl': 0,
      };

      final jsonString = jsonEncode(cacheData);
      final cachedData = jsonDecode(jsonString) as Map<String, dynamic>;

      // This should not throw an error
      expect(() {
        final content =
            cachedData['content'] == null
                ? <int>[]
                : (cachedData['content'] as List).cast<int>();
        final headers = (cachedData['headers'] as List?)?.cast<int>();

        expect(content, isA<List<int>>());
        expect(headers, isNull);
      }, returnsNormally);

      print('✅ Null handling test passed!');
    });
  });
}
