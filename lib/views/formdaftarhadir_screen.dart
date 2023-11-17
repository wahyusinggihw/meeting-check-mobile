import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:meeting_check/services/rapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/alertdialog.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:meeting_check/views/widgets/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class FormDaftarHadir extends StatefulWidget {
  const FormDaftarHadir({super.key});

  @override
  State<FormDaftarHadir> createState() => _FormDaftarHadirState();
}

class _FormDaftarHadirState extends State<FormDaftarHadir> {
  final GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String kodeRapat = arguments?['kodeRapat'] ?? '';
    var rapatData = arguments?['rapat'];
    bool isSigned = false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Form Daftar Hadir'),
      ),
      body: buildForm(kodeRapat, rapatData, isSigned),
    );
  }

  Widget buildForm(kodeRapat, rapatData, isSigned) {
    RapatServices rapatServices = RapatServices();
    return FutureBuilder<dynamic>(
      future: rapatServices.getRapatByKode(
          kodeRapat), // Replace 'kodeRapat' with the actual value
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No data available.');
        } else {
          // ignore: unused_local_variable
          final responseData = snapshot.data!['data'];
          // return Text('Judul Rapat: $judulRapat');
          return buildRapatForm(rapatData, isSigned);
        }
      },
    );
  }

  Widget buildRapatForm(rapatData, isSigned) {
    return SingleChildScrollView(
      child: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('Agenda Rapat',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 30),
                    detailRapatAgenda('Kode Rapat', rapatData.kodeRapat),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    detailRapatAgenda('Judul Rapat', rapatData.agendaRapat),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    detailRapatAgenda('Tanggal', rapatData.tanggal),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    detailRapatAgenda('Jam', rapatData.jam),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    detailRapatAgenda('Tempat', rapatData.tempat),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Deskripsi',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          rapatData.deskripsi,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tanda Tangan',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 4,
                        child: ClipRect(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              SfSignaturePad(
                                key: _signaturePadKey,
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                onDrawEnd: () {
                                  isSigned = true;
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  _signaturePadKey.currentState!.clear();
                                  isSigned = false;
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  color: secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    primaryButton(
                        text: 'Submit',
                        onPressed: () async {
                          // ...
                          if (!isSigned) {
                            // Show an error snackbar if the signature is empty
                            await errorFlushbar(
                                context, 'Tanda tangan belum diisi');
                          } else {
                            var image =
                                await _signaturePadKey.currentState!.toImage();
                            submitAbsen(rapatData.kodeRapat, image);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget detailRapatAgenda(String title, String value) => Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      );

  submitAbsen(kodeRapat, signatureImage) async {
    RapatServices rapatServices = RapatServices();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user').toString());
    var rapat = await rapatServices.getRapatByKode(kodeRapat);

    List<int> bytes = await signatureImage
        .toByteData(format: ui.ImageByteFormat.png)
        .then((data) => data!.buffer.asUint8List());
    String base64Image = base64Encode(bytes);
    String getBase64Image(String base64String) {
      String format = 'data:image/png;base64,';
      if (base64String.contains(format)) {
        return base64String;
      } else {
        return format + base64String;
      }
    }

    String base64Signature = getBase64Image(base64Image);

    // print('Base64 Signature: $base64Signature');
    // print('errorkan' + rapat['error']);
    if (rapat['error'] == true) {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      errorDialog(context, 'Gagal', rapat['message']);
    } else {
      var statusAbsen = await rapatServices.absensiStore(
        nip: user['nip'],
        kodeRapat: rapat['data']['kode_rapat'],
        noHp: user['no_hp'],
        nama: user['nama_lengkap'],
        alamat: user['alamat'],
        asalInstansi: user['ket_ukerja'],
        signatureData: base64Signature,
      );

      if (statusAbsen['error'] != false) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        errorDialog(context, 'Gagal', statusAbsen['message']);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        successFlushbar(context, 'Berhasil absen',
            duration: const Duration(seconds: 5));
      }
    }
  }
}
