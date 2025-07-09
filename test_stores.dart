import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

void main() {
  // Test what stores are available
  print('Available stores:');
  print('MemCacheStore: $MemCacheStore');

  // Try to access other stores that might be available
  try {
    // Check if these constructors exist
    print('Creating MemCacheStore...');
    final memStore = MemCacheStore();
    print('MemCacheStore created successfully');

    // Check for DbCacheStore (might be available)
    print('Looking for other cache store types...');
  } catch (e) {
    print('Error: $e');
  }
}
