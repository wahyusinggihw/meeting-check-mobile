import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meeting_check/services/rapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/home_screen.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/qr_screen.dart';
import 'dart:async';
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
    // Future<void> scanBarcodeNormal() async {
    //   String barcodeScanRes;
    //   // Platform messages may fail, so we use a try/catch PlatformException.
    //   try {
    //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    //         '#ff6666', 'Cancel', true, ScanMode.QR);
    //     print(barcodeScanRes);
    //     RapatServices().extractCode(_scanBarcode);
    //   } on PlatformException {
    //     barcodeScanRes = 'Failed to get platform version.';
    //   }

    //   // If the widget was removed from the tree while the asynchronous platform
    //   // message was in flight, we want to discard the reply rather than calling
    //   // setState to update our non-existent appearance.
    //   if (!mounted) return;

    //   setState(() {
    //     _scanBarcode = barcodeScanRes;
    //   });
    // }

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
        String? kodeRapat = uri.queryParameters['kode_rapat'];

        setState(() {
          qrCodeResult = kodeRapat ?? "kode_rapat not found";
        });
        print(qrCodeResult);
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
