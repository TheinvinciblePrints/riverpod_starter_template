import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/providers/persistent_cache_provider.dart';

/// Test to verify persistent cache providers work correctly
class PersistentCacheTest extends ConsumerWidget {
  const PersistentCacheTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Persistent Cache Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                try {
                  final store = await ref.read(
                    persistentCacheStoreProvider.future,
                  );
                  debugPrint('✅ Persistent cache store loaded: $store');

                  final options = await ref.read(
                    persistentCacheOptionsProvider.future,
                  );
                  debugPrint(
                    '✅ Persistent cache options loaded: ${options.policy}',
                  );

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ Persistent cache providers working!'),
                      ),
                    );
                  }
                } catch (e) {
                  debugPrint('❌ Error testing persistent cache: $e');
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('❌ Error: $e')));
                  }
                }
              },
              child: const Text('Test Persistent Cache'),
            ),
            const SizedBox(height: 20),
            const Text(
              'This tests the HiveCacheStore implementation',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
