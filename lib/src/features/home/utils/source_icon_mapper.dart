/// Utility class for mapping source IDs to icon assets
class SourceIconMapper {
  /// Maps a source ID to its corresponding icon asset path
  /// Returns null if no matching icon is found
  static String? mapSourceIdToIcon(String sourceId) {
    // Normalize the source ID for comparison
    final normalizedId = sourceId.toLowerCase();

    // Map of source IDs to icon assets
    final Map<String, String> sourceIconMap = {
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
      'the-wall-street-journal':
          'assets/icons/scmp.png', // Using SCMP icon as fallback
      'vox': 'assets/icons/vox.png',
    };

    return sourceIconMap[normalizedId];
  }

  /// Gets a default icon if no matching icon is found
  static String getDefaultIcon() {
    return 'assets/icons/cnn.png'; // Using CNN as default icon
  }
}
