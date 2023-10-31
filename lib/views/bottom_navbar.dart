import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meeting_check/services/rapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/home_screen.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/qr_screen.dart';
import 'package:meeting_check/views/widgets/alertdialog.dart';
import 'dart:async';
import 'package:meeting_check/views/widgets/snackbar.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  String _scanBarcode = 'Unknown';
  final screens = const [
    HomeScreen(),
    QrScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    RapatServices rapatServices = RapatServices();
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
        String? uuid = uri.pathSegments[3];

        setState(() {
          qrCodeResult = uuid ?? "kode_rapat not found";
        });
        var rapat = await rapatServices.getAgendaRapatById(uuid);
        print(rapat['status']);
        // print(rapat['agendaRapat'].agendaRapat);
        if (rapat['status'] == true) {
          successSnackbar(context, 'Silahkan melakukan tanda tangan',
              duration: 5);
          Navigator.pushNamed(context, '/form-daftarhadir', arguments: {
            'idRapat': uuid,
            'rapat': rapat['agendaRapat'],
          });
        } else {
          errorDialog(context, 'Error', rapat['message']);
        }

        // print("idRapat:" + qrCodeResult);
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        // shape: BeveledRectangleBorder(
        //   borderRadius: BorderRadius.circular(2),
        // ),
        title: Text(widget.title),
      ),
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
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                    onTap: () {
                      scanQRCode();
                      // if (_scanBarcode != '-1') {
                      // Navigator.pushNamed(context, '/success-qr', arguments: {
                      //   'qr': _scanBarcode,
                      //   'status': 'Terimakasih telah mengisi daftar hadir!'
                      // });
                      // } else {
                      //   Navigator.pushNamed(context, '/qr-error',
                      //       arguments: {'status': 'Kode Qr tidak valid'});
                      // }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.qr_code_scanner_rounded),
                    )),
              ],
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
