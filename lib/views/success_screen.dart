import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    var rapatData = arguments?['rapat'];
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // titleSpacing: 0.0,
        backgroundColor: primaryColor,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: false,
        title: const Text('Formulir Daftar Hadir'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).size.width > 600
                ? const EdgeInsets.symmetric(horizontal: 100, vertical: 15)
                : const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Text('Agenda Rapat',
                    //     style: Theme.of(context).textTheme.titleMedium),
                    // const SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rapatData.agendaRapat,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_rounded,
                                color: secondaryColor, size: 15),
                            const SizedBox(width: 2),
                            Text(
                              rapatData.tanggal,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(width: 50),
                            const Icon(Icons.access_time_rounded,
                                color: secondaryColor, size: 15),
                            const SizedBox(width: 2),
                            Text(
                              rapatData.jam,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 70),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            'assets/images/logo-2.png',
                            width: 150,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Text(
                            'Anda telah melakukan presensi pada kegiatan ini',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              // color: secondaryColor,
                            ),
                            // maxLines: 2,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
