import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/providers/search_provider.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  // final String? hintText;
  // final InputDecorationTheme? inputTheme;

  // CustomSearchDelegate({this.hintText, this.inputTheme});

  @override
  String? get searchFieldLabel => 'Cari...';

  // @override
  // InputDecorationTheme? get searchFieldDecorationTheme => inputTheme;

  // @override
  // TextStyle? get searchFieldStyle => TextStyle(
  //       color: Colors.white,
  //       fontSize: 16,
  //       fontFamily: 'Roboto',
  //     );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.white,
        selectionHandleColor: Colors.white,
      ),
      textTheme: TextTheme(
        // search input theme
        headlineMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        titleLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
        titleMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: textColor,
        ),
        titleSmall: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: secondaryColor,
        ),
        // search result theme
        bodyMedium: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xff000000),
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle:
            TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Roboto'),
        border: InputBorder.none,
        focusColor: Colors.white,
      ),
    );
    return theme;
  }

  // List<String> searchTerms = [
  //   'Apple',
  //   'Apricot',
  //   'Avocado',
  //   'Banana',
  //   'Bilberry',
  // ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
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
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
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
              leading: const Icon(Icons.search, color: secondaryColor),
              title: Row(
                children: [
                  Expanded(child: Text(result.agendaRapat)),
                  const SizedBox(width: 2),
                ],
              ),
              subtitle: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.account_balance_rounded,
                      size: 15, color: secondaryColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      result.namaInstansi,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(
                        color: secondaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: riwayatKehadiran
                  ? const Icon(
                      Icons.check_circle,
                      size: 15,
                      color: primaryColor,
                    )
                  : const Text(''),
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
                updateSearchHistory(
                    context, result.agendaRapat, result.namaInstansi);
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
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 16.0,
                      bottom: 1,
                    ),
                    child: Row(
                      children: [
                        const Text(
                          'Histori Pencarian',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            searchHistoryModel.clearSearchHistory();
                          },
                          child: const Text(
                            'hapus',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Display the last 3 search history with a delete button
                  for (var i = searchHistoryModel.searchHistory.length - 1;
                      i >= 0 &&
                          i > searchHistoryModel.searchHistory.length - 11;
                      i--)
                    ListTile(
                      title: Text(searchHistoryModel.searchHistory[i].title),
                      subtitle: Row(
                        children: [
                          const Icon(
                            Icons.account_balance_rounded,
                            size: 15,
                            color: secondaryColor,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              searchHistoryModel.searchHistory[i].subtitle,
                              style: const TextStyle(
                                color: secondaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      leading: const Icon(Icons.history, color: secondaryColor),
                      trailing: IconButton(
                        onPressed: () {
                          searchHistoryModel.removeSearchHistory(i);
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                      onTap: () {
                        // Handle tapping on a history item
                        query = searchHistoryModel.searchHistory[i].title
                            .toLowerCase();
                        showResults(context);
                      },
                    ),
                ],
              ),
            );
    } else {
      return buildResults(context);
    }
  }

  void updateSearchHistory(
      BuildContext context, String title, String subtitle) {
    final searchHistoryModel =
        Provider.of<SearchHistoryModel>(context, listen: false);
    searchHistoryModel.addSearchHistory(title, subtitle);
  }
}
