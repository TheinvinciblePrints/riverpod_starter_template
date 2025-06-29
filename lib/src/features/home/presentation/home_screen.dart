import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_starter_template/src/gen/assets.gen.dart';

import '../../../shared/textfields/custom_text_field.dart';
import '../../../utils/extensions/context_extensions.dart';
import '../domain/article_model.dart';
import 'trending_articles_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data for other UI components
    final latestArticles = [
      ArticleModel(
        title:
            'Ukraine\'s President Zelensky to BBC: Blood money being paid for Russian oil',
        category: 'Europe',
        source: 'BBC News',
        timeAgo: '14m ago',
        imageUrl: 'https://picsum.photos/200/150?random=2',
      ),
      ArticleModel(
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 120,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 24.0),
          child: AppAssets.images.appLogo.image(height: 30, width: 99),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 24.0),
            child: AppAssets.icons.settingIcon.svg(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 16),
              const _SearchBar(),
              const SizedBox(height: 24),
              _SectionHeader(title: 'Trending', onSeeAllPressed: () {}),
              const SizedBox(height: 12),
              // Using our real API trending articles widget
              const TrendingArticlesWidget(),
              const SizedBox(height: 24),
              _SectionHeader(title: 'Latest', onSeeAllPressed: () {}),
              const SizedBox(height: 8),
              _CategoryFilter(categories: categories),
              const SizedBox(height: 16),
              ...latestArticles.map(
                (article) => _ArticleItem(article: article),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Private widget for displaying the search bar
class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      type: CustomTextFieldType.icon,
      state: CustomTextFieldState.initial,
      labelText: 'Search',
      labelTextColor: context.colorTheme.searchLabelColor,
      icon: Padding(
        padding: const EdgeInsets.all(12.0),
        child: AppAssets.icons.searchIcon.svg(
          colorFilter: ColorFilter.mode(
            context.colorTheme.searchIconColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      suffixIcon: IconButton(
        padding: const EdgeInsets.only(right: 12.0),
        icon: AppAssets.icons.filterIcon.svg(
          colorFilter: ColorFilter.mode(
            context.colorTheme.searchIconColor,
            BlendMode.srcIn,
          ),
        ),
        onPressed: () {},
      ),
      onClear: () {},
    );
  }
}

// Private widget for displaying section headers
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  const _SectionHeader({required this.title, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: context.textTheme.linkMedium),
        TextButton(
          onPressed: onSeeAllPressed,
          child: Text('See all', style: context.textTheme.linkMedium),
        ),
      ],
    );
  }
}

// Private widget for displaying category filters
class _CategoryFilter extends StatelessWidget {
  final List<String> categories;

  const _CategoryFilter({required this.categories});

  @override
  Widget build(BuildContext context) {
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
}

// Private widget for displaying article items
class _ArticleItem extends StatelessWidget {
  final ArticleModel article;

  const _ArticleItem({required this.article});

  @override
  Widget build(BuildContext context) {
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
            child: Column(
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
                    article.sourceIcon != null
                        ? CircleAvatar(
                          backgroundImage: AssetImage(article.sourceIcon!),
                          radius: 10,
                        )
                        : CircleAvatar(
                          backgroundColor:
                              article.source == 'BBC News'
                                  ? Colors.red
                                  : Colors.red.shade700,
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
          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }
}
