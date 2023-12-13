import 'package:flutter/material.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/roundedappbar.dart';
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: const RoundedAppBar(
            height: kToolbarHeight,
            tabBar: TabBar(
              tabs: [
                Tab(text: 'TERSEDIA'),
                Tab(text: 'SELESAI'),
              ],
              labelStyle: TextStyle(
                fontSize: 14,
                // fontWeight: FontWeight.bold,
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2.0, color: primaryColor),
                insets: EdgeInsets.symmetric(horizontal: 2.0),
              ),
            ),
          ),
          backgroundColor: primaryColor,
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(20),
              //   topRight: Radius.circular(20),
              // )
            ),
            child: Padding(
              padding: MediaQuery.of(context).size.width > 600
                  ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
                  : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: TabBarView(
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Agenda Rapat',
                        //     style: Theme.of(context).textTheme.titleMedium),
                        Expanded(
                          child: Consumer<AgendaRapatProvider>(
                              builder: (context, agendaProvider, child) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await agendaProvider.fetchAgendaRapat();
                              },
                              child: ListView.builder(
                                itemCount:
                                    agendaProvider.agendaRapatList.isEmpty
                                        ? 1
                                        : agendaProvider.agendaRapatList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (agendaProvider.agendaRapatList.isEmpty) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3),
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                    return ListTile(
                                      shape: ShapeBorder.lerp(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          1),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/form-daftarhadir',
                                            arguments: {
                                              'title': 'Detail Rapat',
                                              'kodeRapat': agendaProvider
                                                  .agendaRapatList[index]
                                                  .kodeRapat,
                                              'rapat': agendaProvider
                                                  .agendaRapatList[index]
                                            });
                                      },
                                      // isThreeLine: true,
                                      leading: kodeRapat(agendaProvider
                                          .agendaRapatList[index].kodeRapat),
                                      // leading: Icon(Icons.event_note,
                                      //     color: secondaryColor),
                                      tileColor: Colors.white,
                                      title: Text(
                                          agendaProvider.agendaRapatList[index]
                                              .agendaRapat,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          )),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            agendaProvider
                                                .agendaRapatList[index].tempat,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: secondaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.calendar_today_rounded,
                                                  color: secondaryColor,
                                                  size: 15),
                                              const SizedBox(width: 2),
                                              Text(
                                                agendaProvider
                                                    .agendaRapatList[index]
                                                    .tanggal,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              const Icon(
                                                  Icons.access_time_rounded,
                                                  color: secondaryColor,
                                                  size: 15),
                                              const SizedBox(width: 2),
                                              Text(
                                                agendaProvider
                                                    .agendaRapatList[index].jam,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: primaryColor,
                                          size: 15),
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
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Agenda Rapat',
                        //     style: Theme.of(context).textTheme.titleMedium),
                        Expanded(
                          child: Consumer<AgendaRapatProvider>(
                              builder: (context, agendaProvider, child) {
                            return RefreshIndicator(
                              onRefresh: () async {
                                await agendaProvider.fetchAgendaRapatSelesai();
                              },
                              child: ListView.builder(
                                itemCount: agendaProvider
                                        .agendaRapatSelesaiList.isEmpty
                                    ? 1
                                    : agendaProvider
                                        .agendaRapatSelesaiList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (agendaProvider
                                      .agendaRapatSelesaiList.isEmpty) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3),
                                      child: const Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
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
                                    return ListTile(
                                      shape: ShapeBorder.lerp(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          1),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/form-daftarhadir',
                                            arguments: {
                                              'title': 'Detail Rapat',
                                              'kodeRapat': agendaProvider
                                                  .agendaRapatSelesaiList[index]
                                                  .kodeRapat,
                                              'rapat': agendaProvider
                                                  .agendaRapatSelesaiList[index]
                                            });
                                      },
                                      // isThreeLine: true,
                                      leading: kodeRapat(agendaProvider
                                          .agendaRapatSelesaiList[index]
                                          .kodeRapat),
                                      // leading: Icon(Icons.event_note,
                                      //     color: secondaryColor),
                                      tileColor: Colors.white,
                                      title: Text(
                                          agendaProvider
                                              .agendaRapatSelesaiList[index]
                                              .agendaRapat,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          )),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            agendaProvider
                                                .agendaRapatSelesaiList[index]
                                                .tempat,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: const TextStyle(
                                              color: secondaryColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.calendar_today_rounded,
                                                  color: secondaryColor,
                                                  size: 15),
                                              const SizedBox(width: 2),
                                              Text(
                                                agendaProvider
                                                    .agendaRapatSelesaiList[
                                                        index]
                                                    .tanggal,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              const Icon(
                                                  Icons.access_time_rounded,
                                                  color: secondaryColor,
                                                  size: 15),
                                              const SizedBox(width: 2),
                                              Text(
                                                agendaProvider
                                                    .agendaRapatSelesaiList[
                                                        index]
                                                    .jam,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                  color: secondaryColor,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: primaryColor,
                                          size: 15),
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
                ],
              ),
            ),
          )),
    );
  }

  Widget kodeRapat(String value) {
    // the value is 123-456, i want to separate to two sections
    // 123
    // 456
    final List<String> split = value.split('-');
    final String firstSection = split[0];
    final String secondSection = split[1];
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: secondaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              firstSection,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              secondSection,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
