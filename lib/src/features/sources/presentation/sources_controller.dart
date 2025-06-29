import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../application/sources_service.dart';
import '../domain/news_source.dart';

part 'sources_controller.g.dart';

// State definition for the sources screen
class SourcesState {
  final bool isLoading;
  final List<NewsSource> sources;
  final String? errorMessage;

  SourcesState({
    this.isLoading = false,
    this.sources = const [],
    this.errorMessage,
  });

  SourcesState copyWith({
    bool? isLoading,
    List<NewsSource>? sources,
    String? errorMessage,
  }) {
    return SourcesState(
      isLoading: isLoading ?? this.isLoading,
      sources: sources ?? this.sources,
      errorMessage: errorMessage,
    );
  }
}

@riverpod
class SourcesController extends _$SourcesController {
  @override
  SourcesState build() {
    return SourcesState(isLoading: true);
  }

  Future<void> loadSources() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final sources = await ref.read(sourcesServiceProvider).getSources();
      state = state.copyWith(isLoading: false, sources: sources);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load sources: ${e.toString()}',
      );
    }
  }

  /// Get a source icon for a given source ID
  String? getSourceIcon(String sourceId) {
    return ref.read(sourcesServiceProvider).getSourceIcon(sourceId);
  }

  /// Get source initials for a given source name
  String getSourceInitials(String sourceName) {
    return ref.read(sourcesServiceProvider).getSourceInitials(sourceName);
  }
}

/// A simpler provider to just get a specific source icon
@riverpod
String? sourceIcon(Ref ref, String sourceId) {
  return ref.watch(sourcesControllerProvider.notifier).getSourceIcon(sourceId);
}

/// A provider to get source initials
@riverpod
String sourceInitials(Ref ref, String sourceName) {
  return ref
      .watch(sourcesControllerProvider.notifier)
      .getSourceInitials(sourceName);
}
