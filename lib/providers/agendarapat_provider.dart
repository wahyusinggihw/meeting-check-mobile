// agenda_rapat_provider.dart
import 'package:flutter/material.dart';
import 'package:meeting_check/models/agendarapat_model.dart';
import 'package:meeting_check/services/agendarapat_services.dart';

class AgendaRapatProvider extends ChangeNotifier {
  List<AgendaRapatModel> _agendaRapatList = [];
  List<AgendaRapatModel> get agendaRapatList => _agendaRapatList;

  Future<void> fetchAgendaRapat() async {
    _agendaRapatList = await AgendaRapatService().getAgendaRapat();
    notifyListeners();
  }

  clearAgendaRapat() {
    _agendaRapatList = [];
    notifyListeners();
  }
}
