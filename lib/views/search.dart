import 'package:flutter/material.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/providers/search_provider.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  final String? hintText;
  final InputDecorationTheme? inputTheme;

  CustomSearchDelegate({this.hintText, this.inputTheme});

  @override
  String? get searchFieldLabel => hintText;

  @override
  InputDecorationTheme? get searchFieldDecorationTheme => inputTheme;

  List<String> searchTerms = [
    'Apple',
    'Apricot',
    'Avocado',
    'Banana',
    'Bilberry',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      // If the query is empty, return an empty widget or a message
      return Container();
    }

    AgendaRapatProvider agendaProvider =
        Provider.of<AgendaRapatProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      agendaProvider.searchAgendaRapat(query);
    });

    return Consumer<AgendaRapatProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.searchedAgendaRapatSearchList.length,
          itemBuilder: (context, index) {
            var result = provider.searchedAgendaRapatSearchList[index];
            bool riwayatKehadiran =
                agendaProvider.searchedAgendaRapatSearchList[index].hadir;
            // print(result.agendaRapat);
            return ListTile(
              title: Row(children: [
                Text(result.agendaRapat),
                const SizedBox(width: 2),
                riwayatKehadiran
                    ? Icon(
                        Icons.check_circle,
                        size: 15,
                        color: primaryColor,
                      )
                    : Text('')
              ]),
              // subtitle: Text(result.tanggal),
              onTap: () {
                if (!riwayatKehadiran) {
                  Navigator.pushNamed(context, '/form-daftarhadir', arguments: {
                    'kodeRapat': agendaProvider
                        .searchedAgendaRapatSearchList[index].kodeRapat,
                    'rapat': agendaProvider.searchedAgendaRapatSearchList[index]
                  });
                } else {
                  Navigator.pushNamed(context, '/success', arguments: {
                    'kodeRapat': agendaProvider
                        .searchedAgendaRapatSearchList[index].kodeRapat,
                    'rapat': agendaProvider.searchedAgendaRapatSearchList[index]
                  });
                }
                updateSearchHistory(context, query, result.agendaRapat);
                // close(context, result.agendaRapat);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return buildResults(context);
    final searchHistoryModel = Provider.of<SearchHistoryModel>(context);
    if (query.isEmpty) {
      return searchHistoryModel.searchHistory.isEmpty
          ? Container()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 1),
                  child: Text(
                    'Histori',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
                  ),
                ),
                // Display the last 3 search history with a delete button
                for (var i = searchHistoryModel.searchHistory.length - 1;
                    i >= 0 && i > searchHistoryModel.searchHistory.length - 4;
                    i--)
                  ListTile(
                    title: Text(searchHistoryModel.searchHistory[i]),
                    trailing: TextButton(
                        onPressed: () {
                          searchHistoryModel.removeSearchHistory(i);
                        },
                        child: const Text(
                          'hapus',
                          style: TextStyle(color: secondaryColor),
                        )),
                    onTap: () {
                      // Handle tapping on a history item
                      query = searchHistoryModel.searchHistory[i];
                      showResults(context);
                    },
                  ),
              ],
            );
    } else {
      return buildResults(context);
    }
  }

  void updateSearchHistory(BuildContext context, String query, String result) {
    final searchHistoryModel =
        Provider.of<SearchHistoryModel>(context, listen: false);
    searchHistoryModel.addSearchHistory(query);
  }
}
