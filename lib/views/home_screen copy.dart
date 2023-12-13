import 'package:flutter/material.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String idInstansi = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Padding(
          
          padding: MediaQuery.of(context).size.width > 600
              ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
              : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Agenda Rapat',
                    style: Theme.of(context).textTheme.titleMedium),
                Expanded(
                  child: Consumer<AgendaRapatProvider>(
                      builder: (context, agendaProvider, child) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await agendaProvider.fetchAgendaRapat();
                      },
                      child: ListView.builder(
                        itemCount: agendaProvider.agendaRapatList.isEmpty
                            ? 1
                            : agendaProvider.agendaRapatList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (agendaProvider.agendaRapatList.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.3),
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.event_note,
                                      color: secondaryColor,
                                      size: 50,
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Tidak ada agenda rapat tersedia',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
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
                                  Navigator.pushNamed(context, '/form-daftarhadir',
                                      arguments: {
                                        'title': 'Detail Rapat',
                                        'kodeRapat': agendaProvider
                                            .agendaRapatList[index].kodeRapat,
                                        'rapat':
                                            agendaProvider.agendaRapatList[index]
                                      });
                                },
                                leading: const Icon(Icons.event_note,
                                    color: secondaryColor),
                                tileColor: Colors.white,
                                title: Text(
                                    agendaProvider
                                        .agendaRapatList[index].agendaRapat,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    )),
                                subtitle: Text(
                                  '${agendaProvider.agendaRapatList[index].jam}, ${agendaProvider.agendaRapatList[index].tanggal}',
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
                          }
                        },
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
