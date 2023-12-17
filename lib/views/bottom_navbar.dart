// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meeting_check/services/rapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/home_screen.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/qr_screen.dart';
import 'package:meeting_check/views/widgets/alertdialog.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meeting_check/views/widgets/snackbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;

  final titles = const [
    'Daftar Rapat',
    'QR Code',
    'Profile',
  ];

  final screens = const [
    HomeScreen(),
    QrScreen(),
    ProfileScreen(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    RapatServices rapatServices = RapatServices();
    // ignore: unused_local_variable
    String qrCodeResult = "Not yet scanned";

    Future<void> scanQRCode() async {
      String codeScanner = await FlutterBarcodeScanner.scanBarcode(
        "#FF3E158D",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (codeScanner != "-1") {
        // QR code scanned successfully, now parse the URL to extract kode_rapat
        Uri uri = Uri.parse(codeScanner);
        // String? kodeRapat = uri.queryParameters['kode_rapat'];
        String? kodeRapat = uri.pathSegments.last;
        log(kodeRapat);
        setState(() {
          qrCodeResult = kodeRapat;
        });
        var rapat = await rapatServices.getAgendaRapatByKode(kodeRapat);
        // log(rapat['error']);
        print(rapat['error']);
        // print(rapat['agendaRapat'].agendaRapat);
        if (rapat['error'] == true) {
          // errorDialog(context, 'Gagal', rapat['message']);
          Navigator.pushNamed(context, '/qr-failed');
          // print('error qr');
          // Navigator.pushReplacementNamed(context, '/qr-success', arguments: {
          //     'rapat': rapat['agendaRapat'],
          //   });
        } else if (rapat['error'] == false) {
          if (rapat['hadir'] == true) {
            Navigator.pushNamed(context, '/qr-success', arguments: {
              'rapat': rapat['agendaRapat'],
            });
            return;
          }
          Navigator.pushNamed(context, '/form-daftarhadir', arguments: {
            'kodeRapat': kodeRapat,
            'rapat': rapat['formData'],
          });
          await successSnackbar(context, 'Silahkan melakukan tanda tangan',
              duration: 5);
        } else {
          errorDialog(context, 'Gagal', 'Terjadi kesalahan');
        }

        // print("idRapat:" + qrCodeResult);
      }
    }

    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: primaryColorLight,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
        child: NavigationBar(
          shadowColor: Colors.black.withOpacity(0.16),
          backgroundColor: Colors.white,
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                    radius: 30,
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      scanQRCode();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.qr_code_scanner_rounded,
                          size: 30,
                        ),
                      ),
                    )),
              ],
            ),
            const NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
