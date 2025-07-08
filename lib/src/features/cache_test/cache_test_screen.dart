import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/features/home/data/news_repository.dart';
import 'package:flutter_riverpod_starter_template/src/features/sources/data/sources_repository.dart';

/// Cache Testing Screen to demonstrate cache hits vs API calls
class CacheTestScreen extends ConsumerWidget {
  const CacheTestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cache Test'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Test Cache Functionality',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Check the debug console to see cache hits vs API calls.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Test News API
            ElevatedButton(
              onPressed: () async {
                print('🧪 [TEST] Testing News API Cache...');
                final repository = await ref.read(
                  newsRepositoryProvider.future,
                );
                final result = await repository.getTopHeadlines(pageSize: 5);

                if (result.isSuccess) {
                  print('✅ [TEST] News API request completed successfully');
                  print(
                    '📊 [TEST] Articles fetched: ${result.dataOrNull?.length ?? 0}',
                  );
                } else {
                  print('❌ [TEST] News API request failed');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Test News API Cache',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 16),

            // Test Sources API
            ElevatedButton(
              onPressed: () async {
                print('🧪 [TEST] Testing Sources API Cache...');
                final repository = await ref.read(
                  sourcesRepositoryProvider.future,
                );
                final result = await repository.getSources();

                if (result.isSuccess) {
                  print('✅ [TEST] Sources API request completed successfully');
                  print(
                    '📊 [TEST] Sources fetched: ${result.dataOrNull?.length ?? 0}',
                  );
                } else {
                  print('❌ [TEST] Sources API request failed');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.all(16),
              ),
              child: const Text(
                'Test Sources API Cache',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 30),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to Interpret Cache Logs:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('✅ [CACHE HIT] = Data served from cache'),
                    Text('❌ [CACHE MISS] = New API request made'),
                    Text('💾 [CACHE STORE] = Data saved to cache'),
                    Text('⏰ [CACHE] = Cache expiration info'),
                    SizedBox(height: 8),
                    Text(
                      'First request will show MISS + STORE.\nSubsequent requests will show HIT.',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
