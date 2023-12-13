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

  Future<void> fetchAgendaRapat() async {
    _agendaRapatList = await AgendaRapatService().getAgendaRapat();
    notifyListeners();
  }

  Future<void> fetchAgendaRapatSelesai() async {
    _agendaRapatSelesaiList =
        await AgendaRapatService().getAgendaRapatSelesai();
    notifyListeners();
  }

  clearAgendaRapat() {
    _agendaRapatList = [];
    notifyListeners();
  }
}
