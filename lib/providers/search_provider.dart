import 'package:flutter/foundation.dart';

class SearchHistoryModel extends ChangeNotifier {
  List<String> searchHistory = [];

  void addSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      searchHistory.add(query);
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
}
