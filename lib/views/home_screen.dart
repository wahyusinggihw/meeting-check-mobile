import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meeting_check/models/agendarapat_model.dart';
import 'package:meeting_check/services/agendarapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // getagenda rapat
  List<String> agenda = <String>[
    'Pertemuan membahas kalender kerja kominfo tahun 2022 dan lain-lain',
    'Koordianasi dengan kepala dinas terkait',
    'Rapat koordinasi bersama sekretaris daerah',
  ];

  late Future<List<AgendaRapatModel>> futureAgendaRapat;

  String idInstansi = '';

  @override
  void initState() {
    super.initState();
    futureAgendaRapat =
        AgendaRapatService().getAgendaRapat() as Future<List<AgendaRapatModel>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: RefreshIndicator(
          onRefresh: () async {
            return Future.delayed(
                const Duration(milliseconds: 500),
                () => setState(() {
                      futureAgendaRapat = AgendaRapatService().getAgendaRapat()
                          as Future<List<AgendaRapatModel>>;
                    }));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Agenda Rapat',
                  style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                  child: FutureBuilder<List<AgendaRapatModel>>(
                future: futureAgendaRapat,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final agendaItems = snapshot.data;
                    return ListView.builder(
                      itemCount: agendaItems!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            shape: ShapeBorder.lerp(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                1),
                            onTap: () {
                              Navigator.pushNamed(context, '/detail-rapat',
                                  arguments: {
                                    'title': 'Detail Rapat',
                                    'agenda': agendaItems[index]
                                  });
                            },
                            leading: const Icon(Icons.event_note,
                                color: secondaryColor),
                            tileColor: Colors.white,
                            title: Text(
                                '${agendaItems[index].jam}, ${agendaItems[index].tanggal}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                )),
                            subtitle: Text(
                              agendaItems[index].agendaRapat,
                              // subtitle: Text(
                              //   '${agenda[index]}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: primaryColor, size: 15),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
