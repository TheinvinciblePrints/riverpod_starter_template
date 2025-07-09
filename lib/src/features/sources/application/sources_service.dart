import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/sources_repository.dart';
import '../domain/news_source.dart';

part 'sources_service.g.dart';

class SourcesService {
  final SourcesRepository _repository;

  SourcesService(this._repository);

  /// Fetch all available sources
  Future<List<NewsSource>> getSources() async {
    // Use default caching policy (respect server headers) instead of forcing cache
    final result = await _repository.getSources();
    if (result.isSuccess) {
      return result.dataOrNull ?? [];
    } else {
      return []; // Return empty list on error
    }
  }

  /// Check if we have a specific source in cache
  bool hasSource(String sourceId) => _repository.hasSource(sourceId);

  /// Get a specific source details
  NewsSource? getSource(String sourceId) => _repository.getSource(sourceId);

  /// Get source icon for a given source ID
  String? getSourceIcon(String sourceId) => _repository.getSourceIcon(sourceId);

  /// Get source initials for a given source name
  String getSourceInitials(String sourceName) =>
      _repository.getSourceInitials(sourceName);
}

@riverpod
Future<SourcesService> sourcesService(Ref ref) async {
  final repository = await ref.watch(sourcesRepositoryProvider.future);
  return SourcesService(repository);
}
