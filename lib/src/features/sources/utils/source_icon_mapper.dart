/// Utility class for mapping source IDs to icon assets
class SourceIconMapper {
  /// Maps a source ID to its corresponding icon asset path
  /// Returns null if no matching icon is found
  static String? mapSourceIdToIcon(String sourceId) {
    // Normalize the source ID for comparison
    final normalizedId = sourceId.toLowerCase();

    // Map of source IDs to icon assets
    final Map<String, String> sourceIconMap = {
      // Only map sources that have an actual icon asset
      'bbc-news': 'assets/icons/bbc.png',
      'bbc-sport': 'assets/icons/bbc.png',
      'buzzfeed': 'assets/icons/buzz_feed.png',
      'cnbc': 'assets/icons/cnbc.png',
      'cnn': 'assets/icons/cnn.png',
      'daily-mail': 'assets/icons/daily_mail.png',
      'cnet': 'assets/icons/cnet.png',
      'time': 'assets/icons/time.png',
      'usa-today': 'assets/icons/usa_today.png',
      'vice-news': 'assets/icons/vice.png',
      'msn': 'assets/icons/msn.png',
      'vox': 'assets/icons/vox.png',
    };

    return sourceIconMap[normalizedId];
  }

  /// Previously returned a default icon, now returns null to use initials instead
  static String? getDefaultIcon() {
    return null; // Return null to use source initials as fallback
  }

  /// Generate initials for a source name
  /// e.g. "Business Insider" -> "BI"
  static String getSourceInitials(String sourceName) {
    if (sourceName.isEmpty) return '?';
    final words = sourceName.trim().split(RegExp(r'\s+'));
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    } else {
      return (words[0][0] + words[1][0]).toUpperCase();
    }
  }
}
