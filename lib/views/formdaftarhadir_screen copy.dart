import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:meeting_check/services/rapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/alertdialog.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:meeting_check/views/widgets/form.dart';
import 'package:meeting_check/views/widgets/tandatangan.dart';
import 'package:signature/signature.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meeting_check/views/widgets/snackbar.dart';

class FormDaftarHadir2 extends StatefulWidget {
  const FormDaftarHadir2({super.key});

  @override
  State<FormDaftarHadir2> createState() => _FormDaftarHadir2State();
}

class _FormDaftarHadir2State extends State<FormDaftarHadir2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
    exportPenColor: Colors.black,
    onDrawStart: () => log('onDrawStart called!'),
    onDrawEnd: () => log('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => log('Value changed'));
  }

  @override
  void dispose() {
    // IMPORTANT to dispose of the controller
    _controller.dispose();
    super.dispose();
  }

  Future<void> exportImage(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          key: Key('snackbarPNG'),
          content: Text('No content'),
        ),
      );
      return;
    }

    final Uint8List? data =
        await _controller.toPngBytes(height: 1000, width: 1000);
    if (data == null) {
      return;
    }

    if (!mounted) return;

    await push(
      context,
      Scaffold(
        appBar: AppBar(
          title: const Text('PNG Image'),
        ),
        body: Center(
          child: Container(
            color: Colors.grey[300],
            child: Image.memory(data),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String idRapat = arguments?['idRapat'] ?? '';
    var rapatData = arguments?['rapat'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Form Daftar Hadir'),
      ),
      body: buildForm(idRapat, rapatData),
    );
  }

  Widget buildForm(idRapat, rapatData) {
    RapatServices rapatServices = RapatServices();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<dynamic>(
          future: rapatServices.getRapatById(
              idRapat), // Replace 'kodeRapat' with the actual value
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Text('No data available.');
            } else {
              final responseData = snapshot.data!['data'];
              // return Text('Judul Rapat: $judulRapat');
              return buildRapatForm(rapatData);
            }
          },
        ),
      ],
    );
  }

  Widget buildRapatForm(rapatData) {
    return Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agenda Rapat',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            const SizedBox(height: 10),
            formDaftarHadir('Judul Rapat', 'rapatData.agendaRapat'),
            const SizedBox(height: 10),
            formDaftarHadir('Jam', 'rapatData.jam'),
            const SizedBox(height: 10),
            formDaftarHadir('Tempat', 'rapatData.tempat'),
            const SizedBox(height: 10),
            formDaftarHadir('Agenda',
                'Quisque in lacus mollis, varius sem viverra, bibendum nunc. Sed dignissim facilisis pretium. Quisque in lacus mollis, varius sem viverra, bibendum nunc. Sed dignissim facilisis pretium.'),
            const SizedBox(height: 10),
            Container(
              height: 48,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primaryColor)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: tandaTanganForm(),
              ),
            ),
            Center(
              child: primaryButton(
                  text: 'Submit',
                  onPressed: () {
                    if (_controller.isEmpty) {
                      // Show an error snackbar if the signature is empty
                      errorSnackbar(context, 'Tanda tangan belum diisi');
                    } else {
                      submitAbsen('rapatData.idAgenda');
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  submitAbsen(uuid) async {
    RapatServices rapatServices = RapatServices();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user').toString());
    var rapat = await rapatServices.getRapatById(uuid);

    // Capture the signature as an image (PNG)
    Uint8List? signatureImage = await _controller.toPngBytes();

    // Encode the image as base64
    String base64Signature = base64Encode(signatureImage as List<int>);

    // Now you have the user's signature as base64
    // You can send it to the server or store it as needed

    // print('Base64 Signature: $base64Signature');
    var statusAbsen = await rapatServices.absensiStore(
      nip: user['nip'],
      kodeRapat: rapat['data']['kode_rapat'],
      noHp: user['no_hp'],
      nama: user['nama_lengkap'],
      alamat: user['alamat'],
      asalInstansi: user['ket_ukerja'],
      signatureData: base64Signature,
    );
    print(statusAbsen);
    if (statusAbsen['status'] == false) {
      Navigator.pop(context);
      errorDialog(context, 'Error', statusAbsen['message']);
    } else {
      successSnackbar(context, 'Berhasil absen');
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  Widget tandaTanganForm() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          "Tanda Tangan",
        ),
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      backgroundColor: Colors.white,
                      scrollable: true,
                      title: Text('Tanda Tangan'),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Signature(
                                      controller: _controller,
                                      width: 200,
                                      height: 200,
                                      backgroundColor: Colors.white),
                                  IconButton(
                                      onPressed: () => _controller.clear(),
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        primaryButton(
                            text: "Submit",
                            onPressed: () async {
                              await _controller.toPngBytes();
                              successSnackbar(context,
                                  'Berhasil disimpan, silahkan submit form',
                                  duration: 5);
                              Navigator.pop(context);
                            })
                      ],
                    );
                  });
            },
            icon: Icon(
              Icons.create,
              color: primaryColor,
              size: 20,
            ))
      ]);
}
