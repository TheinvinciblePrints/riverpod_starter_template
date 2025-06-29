import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/shared/widgets/app_error_widget.dart';
import 'package:flutter_riverpod_starter_template/src/shared/widgets/app_loader.dart';

import 'sources_controller.dart';

class SourcesScreen extends ConsumerStatefulWidget {
  const SourcesScreen({super.key});

  @override
  ConsumerState<SourcesScreen> createState() => _SourcesScreenState();
}

class _SourcesScreenState extends ConsumerState<SourcesScreen> {
  @override
  void initState() {
    super.initState();
    // Load sources when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sourcesControllerProvider.notifier).loadSources();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sourcesControllerProvider);

    if (state.isLoading) {
      return const Scaffold(body: AppLoader());
    }

    if (state.errorMessage != null) {
      return Scaffold(
        body: AppErrorWidget(
          title: 'Error Loading Sources',
          message: state.errorMessage!,
          onRetry:
              () => ref.read(sourcesControllerProvider.notifier).loadSources(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('News Sources'), elevation: 0),
      body: ListView.builder(
        itemCount: state.sources.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final source = state.sources[index];
          return SourceCard(source: source);
        },
      ),
    );
  }
}

class SourceCard extends StatelessWidget {
  final dynamic source;

  const SourceCard({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    final hasIcon = source.icon != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                hasIcon
                    ? Image.asset(source.icon!, width: 32, height: 32)
                    : CircleAvatar(
                      radius: 16,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        _getInitials(source.name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    source.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    source.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(source.description),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.language, size: 16),
                const SizedBox(width: 4),
                Text(source.language.toUpperCase()),
                const SizedBox(width: 12),
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Text(source.country.toUpperCase()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    } else {
      return (words[0][0] + words[1][0]).toUpperCase();
    }
  }
}
