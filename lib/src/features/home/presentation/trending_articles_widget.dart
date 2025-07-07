import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../network/network.dart';
import '../../../shared/widgets/app_error_widget.dart';
import '../../../utils/extensions/context_extensions.dart';
import '../domain/article_model.dart';
import 'trending_news_controller.dart';

class TrendingArticlesWidget extends ConsumerWidget {
  const TrendingArticlesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingNews = ref.watch(trendingNewsProvider);

    return trendingNews.when(
      loading:
          () => SizedBox(
            height: context.screenHeight * 0.3,
            width: double.infinity,
            // Show a loader while fetching trending news
            child: const Center(child: CircularProgressIndicator()),
          ),
      error: (error, _) {
        final message =
            (error is NetworkFailure) ? error.message : 'Something went wrong';
        return AppErrorWidget(
          title: 'Error Loading Sources',
          message: message,
          onRetry:
              () => ref.read(trendingNewsProvider.notifier).fetchTrendingNews(),
        );
      },
      data: (articles) {
        if (articles.isEmpty) {
          return const Center(child: Text('No trending news available.'));
        }

        final first = articles.first;

        return _buildTrendingArticleCard(context, first);
      },
    );
  }

  // Method to build the trending article card
  Widget _buildTrendingArticleCard(BuildContext context, ArticleModel article) {
    debugPrint('TrendingArticle: ${article.country}');
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
            onError:
                (_, __) => const AssetImage('assets/images/placeholder.png'),
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
                        article.sourceIcon != null
                            ? CircleAvatar(
                              backgroundImage: AssetImage(article.sourceIcon!),
                              radius: 10,
                            )
                            : CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 10,
                              child: Text(
                                article.sourceInitials,
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
