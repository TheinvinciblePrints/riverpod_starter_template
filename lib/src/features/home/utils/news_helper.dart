import '../domain/news_article.dart';

class NewsHelper {
  // Format publishedAt date to relative time
  static String getTimeAgo(String publishedAt) {
    try {
      final DateTime dateTime = DateTime.parse(publishedAt);
      final DateTime now = DateTime.now();
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

  // Get category from article (we'll use a default since NewsAPI doesn't provide categories)
  static String getCategory(NewsArticle article) {
    // In a real app, we might get categories from content analysis or metadata
    // For this demo, we'll extract from the title or use a default
    final title = article.title.toLowerCase();

    if (title.contains('politic') ||
        title.contains('president') ||
        title.contains('government')) {
      return 'Politics';
    } else if (title.contains('sport') ||
        title.contains('game') ||
        title.contains('nba')) {
      return 'Sports';
    } else if (title.contains('health') ||
        title.contains('covid') ||
        title.contains('virus')) {
      return 'Health';
    } else if (title.contains('tech') ||
        title.contains('ai') ||
        title.contains('app')) {
      return 'Technology';
    } else if (title.contains('business') ||
        title.contains('stock') ||
        title.contains('market')) {
      return 'Business';
    } else {
      return 'General';
    }
  }

  // Get source name safely
  static String getSourceName(NewsArticle article) {
    return article.source?.name ?? 'Unknown';
  }

  // Get first letter of source name
  static String getSourceInitial(NewsArticle article) {
    final sourceName = getSourceName(article);
    return sourceName.isNotEmpty ? sourceName[0] : 'N';
  }
}
