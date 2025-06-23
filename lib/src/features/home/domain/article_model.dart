import 'news_article.dart';

/// A view model that adapts the API NewsArticle model to
/// what our UI components need
class ArticleModel {
  final String title;
  final String category;
  final String source;
  final String timeAgo;
  final String? imageUrl;

  ArticleModel({
    required this.title,
    required this.category,
    required this.source,
    required this.timeAgo,
    this.imageUrl,
  });

  /// Factory to create an ArticleViewModel from a NewsArticle
  factory ArticleModel.fromNewsArticle(NewsArticle article) {
    return ArticleModel(
      title: article.title,
      // Derive category from title content since API doesn't provide it
      category: _getCategoryFromTitle(article.title),
      // Get source name safely
      source: article.source?.name ?? 'Unknown',
      // Format the timestamp
      timeAgo: _formatTimeAgo(article.publishedAt),
      // Use URL to image if available
      imageUrl: article.imageUrl?.isNotEmpty == true ? article.imageUrl : null,
    );
  }

  /// Helper method to determine a category from the article title
  static String _getCategoryFromTitle(String title) {
    final lowerTitle = title.toLowerCase();

    if (lowerTitle.contains('politic') ||
        lowerTitle.contains('president') ||
        lowerTitle.contains('government')) {
      return 'Politics';
    } else if (lowerTitle.contains('sport') ||
        lowerTitle.contains('game') ||
        lowerTitle.contains('nba')) {
      return 'Sports';
    } else if (lowerTitle.contains('health') ||
        lowerTitle.contains('covid') ||
        lowerTitle.contains('virus')) {
      return 'Health';
    } else if (lowerTitle.contains('tech') || lowerTitle.contains('ai')) {
      return 'Technology';
    } else if (lowerTitle.contains('business') ||
        lowerTitle.contains('market')) {
      return 'Business';
    } else {
      return 'General';
    }
  }

  /// Format timestamp to relative time
  static String _formatTimeAgo(String publishedAt) {
    try {
      final dateTime = DateTime.parse(publishedAt);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (_) {
      return 'Unknown time';
    }
  }
}
