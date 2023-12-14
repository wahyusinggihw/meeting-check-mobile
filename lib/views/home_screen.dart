import 'package:flutter/material.dart';
import 'package:meeting_check/models/agendarapat_model.dart';
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
  List<AgendaRapatModel> agendaList = [];
  bool showSearchForm = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AgendaRapatProvider agendaProvider =
        Provider.of<AgendaRapatProvider>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            bottom: const RoundedAppBar(
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
            // leading: const Icon(Icons.menu_rounded),
            actions: [
              if (showSearchForm)
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 4, 0, 4),
                    child: TextField(
                      autofocus: true,
                      cursorColor: Colors.white,
                      controller: searchController,
                      onChanged: (value) {
                        agendaProvider.searchAgendaRapat(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        focusColor: primaryColorLight,
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              agendaProvider.searchAgendaRapat('');
                              searchController.clear();
                              showSearchForm = !showSearchForm;
                            });
                          },
                          icon: const Icon(Icons.close),
                          color: Colors.white,
                        ),
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              else
                IconButton(
                  onPressed: () {
                    setState(() {
                      showSearchForm = !showSearchForm;
                    });
                  },
                  icon: const Icon(Icons.search),
                  color: Colors.white,
                ),
            ],
            // elevation: 2.0,
            backgroundColor: primaryColor,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            centerTitle: false,
            // shape: BeveledRectangleBorder(
            //   borderRadius: BorderRadius.circular(2),
            // ),
            // title: Text(widget.title),
            title: Text('Daftar Rapat'),
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
                                await agendaProvider.fetchAgendaRapatSelesai();
                              },
                              child: ListView.builder(
                                itemCount: agendaProvider
                                        .searchedAgendaRapatList.isEmpty
                                    ? 1
                                    : agendaProvider
                                        .searchedAgendaRapatList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (agendaProvider
                                      .searchedAgendaRapatList.isEmpty) {
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
                                        bool riwayatKehadiran = agendaProvider
                                            .searchedAgendaRapatList[index]
                                            .hadir;
                                        if (!riwayatKehadiran) {
                                          Navigator.pushNamed(
                                              context, '/form-daftarhadir',
                                              arguments: {
                                                'title': 'Detail Rapat',
                                                'kodeRapat': agendaProvider
                                                    .searchedAgendaRapatList[
                                                        index]
                                                    .kodeRapat,
                                                'rapat': agendaProvider
                                                        .searchedAgendaRapatList[
                                                    index]
                                              });
                                        } else {
                                          Navigator.pushNamed(
                                              context, '/success',
                                              arguments: {
                                                'title': 'Detail Rapat',
                                                'kodeRapat': agendaProvider
                                                    .searchedAgendaRapatList[
                                                        index]
                                                    .kodeRapat,
                                                'rapat': agendaProvider
                                                        .searchedAgendaRapatList[
                                                    index]
                                              });
                                        }
                                      },
                                      // isThreeLine: true,
                                      leading: kodeRapat(agendaProvider
                                          .searchedAgendaRapatList[index]
                                          .kodeRapat),
                                      // leading: Icon(Icons.event_note,
                                      //     color: secondaryColor),
                                      tileColor: Colors.white,
                                      title: Text(
                                          agendaProvider
                                              .searchedAgendaRapatList[index]
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
                                                .searchedAgendaRapatList[index]
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
                                              const Icon(Icons.calendar_month,
                                                  color: secondaryColor,
                                                  size: 15),
                                              const SizedBox(width: 2),
                                              Text(
                                                agendaProvider
                                                    .searchedAgendaRapatList[
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
                                                    .searchedAgendaRapatList[
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
                                      trailing: Icon(
                                          agendaProvider
                                                  .searchedAgendaRapatList[
                                                      index]
                                                  .hadir
                                              ? Icons.check_circle
                                              : Icons.arrow_forward_ios,
                                          color: primaryColor,
                                          size: 20),
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

                  // AGENDA SELESAI
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
                                await agendaProvider.fetchAgendaRapatSelesai();
                              },
                              child: ListView.builder(
                                itemCount: agendaProvider
                                        .searchedAgendaRapatSelesaiList.isEmpty
                                    ? 1
                                    : agendaProvider
                                        .searchedAgendaRapatSelesaiList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  if (agendaProvider
                                      .searchedAgendaRapatSelesaiList.isEmpty) {
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
                                        bool riwayatKehadiran = agendaProvider
                                            .searchedAgendaRapatSelesaiList[
                                                index]
                                            .hadir;
                                        if (!riwayatKehadiran) {
                                          Navigator.pushNamed(
                                              context, '/form-daftarhadir',
                                              arguments: {
                                                'title': 'Detail Rapat',
                                                'kodeRapat': agendaProvider
                                                    .searchedAgendaRapatSelesaiList[
                                                        index]
                                                    .kodeRapat,
                                                'rapat': agendaProvider
                                                        .searchedAgendaRapatSelesaiList[
                                                    index]
                                              });
                                        } else {
                                          Navigator.pushNamed(
                                              context, '/success',
                                              arguments: {
                                                'title': 'Detail Rapat',
                                                'kodeRapat': agendaProvider
                                                    .searchedAgendaRapatSelesaiList[
                                                        index]
                                                    .kodeRapat,
                                                'rapat': agendaProvider
                                                        .searchedAgendaRapatSelesaiList[
                                                    index]
                                              });
                                        }
                                      },
                                      // isThreeLine: true,
                                      leading: kodeRapat(agendaProvider
                                          .searchedAgendaRapatSelesaiList[index]
                                          .kodeRapat),
                                      // leading: Icon(Icons.event_note,
                                      //     color: secondaryColor),
                                      tileColor: Colors.white,
                                      title: Text(
                                          agendaProvider
                                              .searchedAgendaRapatSelesaiList[
                                                  index]
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
                                                .searchedAgendaRapatSelesaiList[
                                                    index]
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
                                                    .searchedAgendaRapatSelesaiList[
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
                                                    .searchedAgendaRapatSelesaiList[
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
                                      trailing: Icon(
                                          agendaProvider
                                                  .searchedAgendaRapatSelesaiList[
                                                      index]
                                                  .hadir
                                              ? Icons.check_circle
                                              : Icons.arrow_forward_ios,
                                          color: primaryColor,
                                          size: 20),
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
