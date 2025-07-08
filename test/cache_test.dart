import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/providers/cache_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  group('Cache Provider Tests', () {
    late Directory tempDir;
    late ProviderContainer container;

    setUpAll(() async {
      // Create temporary directory for testing
      tempDir = await Directory.systemTemp.createTemp('test_cache');

      // Initialize Hive for testing
      await Hive.initFlutter(tempDir.path);
    });

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() async {
      container.dispose();
      await Hive.deleteBoxFromDisk('dio_cache_responses');
    });

    tearDownAll(() async {
      await tempDir.delete(recursive: true);
    });

    test('should initialize cache store successfully', () async {
      final cacheStore = await container.read(cacheStoreProvider.future);
      expect(cacheStore, isNotNull);
      expect(cacheStore, isA<HivePersistentCacheStore>());
    });

    test('should create cache options with proper settings', () async {
      final cacheOptions = await container.read(cacheOptionsProvider.future);
      expect(cacheOptions, isNotNull);
      expect(cacheOptions.maxStale, equals(const Duration(days: 7)));
      expect(cacheOptions.policy, equals(CachePolicy.forceCache));
    });

    test('should cache and retrieve data', () async {
      final store = HivePersistentCacheStore();
      await store.initialize();

      // Create a mock cache response
      final response = CacheResponse(
        key: 'test_key',
        url: 'https://example.com/test',
        eTag: null,
        lastModified: null,
        maxStale: null,
        content: [1, 2, 3, 4, 5],
        date: DateTime.now(),
        expires: DateTime.now().add(const Duration(hours: 1)),
        headers: null,
        requestDate: DateTime.now(),
        responseDate: DateTime.now(),
        cacheControl: CacheControl(maxAge: 3600),
        priority: CachePriority.normal,
      );

      // Store the response
      await store.set(response);

      // Retrieve the response
      final cachedResponse = await store.get('test_key');
      expect(cachedResponse, isNotNull);
      expect(cachedResponse!.key, equals('test_key'));
      expect(cachedResponse.url, equals('https://example.com/test'));
      expect(cachedResponse.content, equals([1, 2, 3, 4, 5]));

      // Test existence
      final exists = await store.exists('test_key');
      expect(exists, isTrue);

      // Test deletion
      await store.delete('test_key');
      final deletedResponse = await store.get('test_key');
      expect(deletedResponse, isNull);

      await store.close();
    });

    test('should handle cache persistence across reinitializations', () async {
      final store1 = HivePersistentCacheStore();
      await store1.initialize();

      // Create and store a response
      final response = CacheResponse(
        key: 'persistent_key',
        url: 'https://example.com/persistent',
        eTag: null,
        lastModified: null,
        maxStale: null,
        content: [10, 20, 30],
        date: DateTime.now(),
        expires: DateTime.now().add(const Duration(hours: 24)),
        headers: null,
        requestDate: DateTime.now(),
        responseDate: DateTime.now(),
        cacheControl: CacheControl(maxAge: 86400),
        priority: CachePriority.high,
      );

      await store1.set(response);
      await store1.close();

      // Create a new store instance to test persistence
      final store2 = HivePersistentCacheStore();
      await store2.initialize();

      // Verify data persisted
      final cachedResponse = await store2.get('persistent_key');
      expect(cachedResponse, isNotNull);
      expect(cachedResponse!.key, equals('persistent_key'));
      expect(cachedResponse.content, equals([10, 20, 30]));

      await store2.close();
    });
  });
}
