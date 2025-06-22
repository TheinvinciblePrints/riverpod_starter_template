import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/textfields/custom_text_field.dart';
import '../../../utils/extensions/context_extensions.dart';

class NewsArticle {
  final String title;
  final String category;
  final String source;
  final String timeAgo;
  final String? imageUrl;

  const NewsArticle({
    required this.title,
    required this.category,
    required this.source,
    required this.timeAgo,
    this.imageUrl,
  });
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sample data
    final trendingArticles = [
      NewsArticle(
        title: 'Russian warship: Moskva sinks in Black Sea',
        category: 'Europe',
        source: 'BBC News',
        timeAgo: '4h ago',
        imageUrl: 'https://picsum.photos/400/300?random=1',
      ),
    ];

    final latestArticles = [
      NewsArticle(
        title:
            'Ukraine\'s President Zelensky to BBC: Blood money being paid for Russian oil',
        category: 'Europe',
        source: 'BBC News',
        timeAgo: '14m ago',
        imageUrl: 'https://picsum.photos/200/150?random=2',
      ),
      NewsArticle(
        title:
            'Her train broke down. Her phone died. And then she met her future husband',
        category: 'Travel',
        source: 'CNN',
        timeAgo: '1h ago',
        imageUrl: 'https://picsum.photos/200/150?random=3',
      ),
    ];

    final categories = [
      'All',
      'Sports',
      'Politics',
      'Business',
      'Health',
      'Travel',
      'Science',
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 8),
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 24),
              _buildSectionHeader('Trending', onSeeAllPressed: () {}),
              const SizedBox(height: 12),
              _buildTrendingArticles(trendingArticles),
              const SizedBox(height: 24),
              _buildSectionHeader('Latest', onSeeAllPressed: () {}),
              const SizedBox(height: 8),
              _buildCategoryFilter(categories),
              const SizedBox(height: 16),
              ...latestArticles.map((article) => _buildArticleItem(article)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Ka',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.crop_square, color: Colors.blue, size: 32),
                const Text(
                  'E',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'ar',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Icon(Icons.notifications_outlined, size: 28),
      ],
    );
  }

  Widget _buildSearchBar() {
    return CustomTextField(
      type: CustomTextFieldType.icon,
      state: CustomTextFieldState.initial,
      labelText: 'Search',
      onClear: () {},
    );
  }

  Widget _buildSectionHeader(
    String title, {
    required VoidCallback onSeeAllPressed,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder:
              (context) =>
                  Text(title, style: context.textTheme.displayMediumBold),
        ),
        Builder(
          builder:
              (context) => TextButton(
                onPressed: onSeeAllPressed,
                child: Text('See all', style: context.textTheme.linkMedium),
              ),
        ),
      ],
    );
  }

  Widget _buildTrendingArticles(List<NewsArticle> articles) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Container(
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
                      color: Colors.black.withValues(alpha: 0.6),
                    ),
                    child: Builder(
                      builder:
                          (context) => Column(
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
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 10,
                                    child: Text(
                                      article.source[0],
                                      style: context.textTheme.textXSmall
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    article.source,
                                    style: context.textTheme.textMedium
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '•',
                                    style: TextStyle(
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    article.timeAgo,
                                    style: context.textTheme.textSmall.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.7,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryFilter(List<String> categories) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == 0;
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side:
                    isSelected
                        ? BorderSide.none
                        : BorderSide(color: Colors.grey.shade300),
                backgroundColor: isSelected ? Colors.blue : Colors.transparent,
              ),
              child: Text(
                categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticleItem(NewsArticle article) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              article.imageUrl ?? 'https://picsum.photos/100/100',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Builder(
              builder:
                  (context) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.category,
                        style: context.textTheme.textSmall.copyWith(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        article.title,
                        style: context.textTheme.textMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                article.source == 'BBC News'
                                    ? Colors.red
                                    : Colors.red.shade700,
                            radius: 10,
                            child: Text(
                              article.source[0],
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
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('•', style: TextStyle(color: Colors.grey)),
                          const SizedBox(width: 8),
                          Text(
                            article.timeAgo,
                            style: context.textTheme.textSmall.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
            ),
          ),
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }
}
