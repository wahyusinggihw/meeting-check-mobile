import 'package:flutter/foundation.dart';

class SearchHistoryEntry {
  final String agendaRapat;
  final String subtitle;
  final String kodeRapat;
  final String namaInstansi;
  final String tempat;
  final String tanggal;
  final String jam;
  final bool riwayatKehadiran;

  SearchHistoryEntry({
    required this.agendaRapat,
    required this.subtitle,
    required this.kodeRapat,
    required this.namaInstansi,
    required this.tempat,
    required this.tanggal,
    required this.jam,
    required this.riwayatKehadiran,
  });
}

class SearchHistoryModel extends ChangeNotifier {
  List<SearchHistoryEntry> searchHistory = [];

  void addSearchHistory(
      String agendaRapat,
      String subtitle,
      String kodeRapat,
      String namaInstansi,
      String tempat,
      String tanggal,
      String jam,
      bool riwayatKehadiran) {
    var entry = SearchHistoryEntry(
        agendaRapat: agendaRapat,
        subtitle: subtitle,
        kodeRapat: kodeRapat,
        namaInstansi: namaInstansi,
        tempat: tempat,
        tanggal: tanggal,
        jam: jam,
        riwayatKehadiran: riwayatKehadiran);

    if (!searchHistory.any((entry) =>
        entry.agendaRapat == agendaRapat && entry.subtitle == subtitle)) {
      searchHistory.add(entry);

      // Keep only the last 3 entries
      if (searchHistory.length > 10) {
        searchHistory.removeAt(0);
      }

      notifyListeners();
    }
  } // addSearchHistory

  //koderapat as key, and entry as value
  //updatedEntry.agendaRapat and updatedEntry.subtitle as key for strong comparison
  void updateSearchHistory(String kodeRapat, SearchHistoryEntry updatedEntry) {
    int index = searchHistory.indexWhere((entry) =>
        entry.kodeRapat == kodeRapat &&
        entry.agendaRapat == updatedEntry.agendaRapat &&
        entry.subtitle == updatedEntry.subtitle);

    if (index != -1) {
      searchHistory[index] = updatedEntry;
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
