import 'package:flutter/foundation.dart';

class SearchHistoryEntry {
  final String title;
  final String subtitle;

  SearchHistoryEntry({
    required this.title,
    required this.subtitle,
  });
}

class SearchHistoryModel extends ChangeNotifier {
  List<SearchHistoryEntry> searchHistory = [];

  void addSearchHistory(String title, String subtitle) {
    var entry = SearchHistoryEntry(title: title, subtitle: subtitle);

    if (!searchHistory
        .any((entry) => entry.title == title && entry.subtitle == subtitle)) {
      searchHistory.add(entry);

      // Keep only the last 3 entries
      if (searchHistory.length > 3) {
        searchHistory.removeAt(0);
      }

      notifyListeners();
    }
  }

  void removeSearchHistory(int index) {
    searchHistory.removeAt(index);
    notifyListeners();
  }

  void clearSearchHistory() {
    searchHistory.clear();
    notifyListeners();
  }
}
