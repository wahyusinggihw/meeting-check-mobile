// agenda_rapat_provider.dart
import 'package:flutter/material.dart';
import 'package:meeting_check/models/agendarapat_model.dart';
import 'package:meeting_check/models/agendarapatselesai_model.dart';
import 'package:meeting_check/services/agendarapat_services.dart';

class AgendaRapatProvider extends ChangeNotifier {
  List<AgendaRapatModel> _agendaRapatList = [];
  List<AgendaRapatModel> get agendaRapatList => _agendaRapatList;
  List<AgendaRapatSelesaiModel> _agendaRapatSelesaiList = [];
  List<AgendaRapatSelesaiModel> get agendaRapatSelesaiList =>
      _agendaRapatSelesaiList;
  String searchQuery = '';
  // searched
  List<AgendaRapatModel> searchedAgendaRapatList = [];
  List<AgendaRapatSelesaiModel> searchedAgendaRapatSelesaiList = [];

  Future<void> fetchAgendaRapat() async {
    _agendaRapatList = await AgendaRapatService().getAgendaRapat();
    // notifyListeners();
    updateData();
  }

  Future<void> fetchAgendaRapatSelesai() async {
    _agendaRapatSelesaiList =
        await AgendaRapatService().getAgendaRapatSelesai();
    // notifyListeners();
    updateSelesaiData();
  }

  // Updated the updateData method to properly filter the list.
  updateData() {
    if (searchQuery.isEmpty) {
      searchedAgendaRapatList = _agendaRapatList;
    } else {
      searchedAgendaRapatList = _agendaRapatList
          .where((element) =>
              element.agendaRapat.toLowerCase().contains(searchQuery))
          .toList();
    }
    notifyListeners();
  }

  updateSelesaiData() {
    if (searchQuery.isEmpty) {
      searchedAgendaRapatSelesaiList = _agendaRapatSelesaiList;
    } else {
      searchedAgendaRapatSelesaiList = _agendaRapatSelesaiList
          .where((element) =>
              element.agendaRapat.toLowerCase().contains(searchQuery))
          .toList();
    }
    notifyListeners();
  }

  searchAgendaRapat(String query) {
    searchQuery = query;
    updateData();
    updateSelesaiData();
  }

  clearAgendaRapat() {
    _agendaRapatList = [];
    notifyListeners();
  }
}
