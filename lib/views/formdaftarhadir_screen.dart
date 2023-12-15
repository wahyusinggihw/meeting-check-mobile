import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/services/helpers.dart';
import 'package:meeting_check/services/rapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/alertdialog.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:meeting_check/views/widgets/flushbar.dart';
import 'package:provider/provider.dart';
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
      backgroundColor: primaryColor,
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        // titleSpacing: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        centerTitle: false,
        title: const Text('Formulir Daftar Hadir'),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: buildForm(kodeRapat, rapatData, isSigned)),
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
    var tanggal = formatDate(rapatData.tanggal);

    return SingleChildScrollView(
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
                          tanggal,
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
                    )
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Tanda Tangan',
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  // width: MediaQuery.of(context).size.width / 1.5,
                  // height: MediaQuery.of(context).size.height / 3,
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
                // SizedBox(height: MediaQuery.of(context).size.height / 10),
                const SizedBox(height: 20),
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
                        submitAbsen(rapatData.kodeRapat, image, context);
                      }
                    }),
              ],
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

  submitAbsen(kodeRapat, signatureImage, context) async {
    RapatServices rapatServices = RapatServices();
    AgendaRapatProvider agendaProvider =
        Provider.of<AgendaRapatProvider>(context, listen: false);

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
        kodeRapat: rapat['data'][0]['kode_rapat'],
        noHp: user['no_hp'],
        nama: user['nama'],
        alamat: user['alamat'],
        asalInstansi: user['instansi'],
        signatureData: base64Signature,
      );

      print(rapat['data'][0]['agenda_rapat']);
      print(statusAbsen['error']);

      // response return error if user already absen
      if (statusAbsen['error'] == false) {
        await agendaProvider.fetchAgendaRapat();
        await agendaProvider.fetchAgendaRapatSelesai();
        Navigator.pushReplacementNamed(context, '/qr-success',
            arguments: {'rapat': rapat['data'][0]});
      }
    }
  }
}
