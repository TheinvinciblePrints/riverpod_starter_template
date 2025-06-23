import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../enums/view_state.dart';
import '../../../utils/extensions/context_extensions.dart';
import '../application/news_provider.dart';

class RealTrendingArticlesWidget extends ConsumerWidget {
  const RealTrendingArticlesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsProvider);

    // Use base properties directly since we implemented BaseState
    if (newsState.viewState == ViewState.loading) {
      return const SizedBox(
        height: 220,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (newsState.viewState == ViewState.failure) {
      return SizedBox(
        height: 220,
        child: Center(child: Text('Error: ${newsState.errorMessage?.tr()}')),
      );
    }

    final articles = newsState.articles;

    if (articles.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('No articles found')),
      );
    }

    // Show only the first article as requested
    final article = articles.first;
    final sourceInitial = article.source.isNotEmpty ? article.source[0] : 'N';

    return SizedBox(
      height: 220,
      child: Container(
        width: 340,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(
              article.imageUrl ?? 'https://picsum.photos/400/200',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  color: Colors.black.withOpacity(0.6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.category,
                      style: context.textTheme.textSmall.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article.title,
                      style: context.textTheme.textLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10,
                          child: Text(
                            sourceInitial,
                            style: context.textTheme.textXSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          article.source,
                          style: context.textTheme.textMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          article.timeAgo,
                          style: context.textTheme.textSmall.copyWith(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ],
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
