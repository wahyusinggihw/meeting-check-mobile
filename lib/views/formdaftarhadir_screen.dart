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

class FormDaftarHadir extends StatefulWidget {
  const FormDaftarHadir({super.key});

  @override
  State<FormDaftarHadir> createState() => _FormDaftarHadirState();
}

class _FormDaftarHadirState extends State<FormDaftarHadir> {
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
    return FutureBuilder<dynamic>(
      future: rapatServices
          .getRapatById(idRapat), // Replace 'kodeRapat' with the actual value
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
    );
  }

  Widget buildRapatForm(rapatData) {
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
                    SizedBox(height: 30),
                    detailRapatAgenda('Judul Rapat', 'rapatData.agendaRapat'),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    detailRapatAgenda('Jam', 'rapatData.jam'),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    detailRapatAgenda('Tempat', 'rapatData.tempat'),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deskripsi',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Tempat ddad Quisque in lacus mollis, varius sem viverra, bibendum nunc. Sed dignissim facilisis pretium. Quisque in lacus mollis, varius sem viverra, bibendum nunc. Sed dignissim facilisis pretium.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    SizedBox(height: 8),
                    Text(
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
                              Signature(
                                controller: _controller,
                                width: double.infinity,
                                height: double.infinity,
                                backgroundColor:
                                    Color.fromARGB(255, 238, 236, 236),
                              ),
                              IconButton(
                                onPressed: () => _controller.clear(),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    primaryButton(
                        text: 'Submit',
                        onPressed: () async {
                          await _controller.toPngBytes();
                          if (_controller.isEmpty) {
                            // Show an error snackbar if the signature is empty
                            errorSnackbar(context, 'Tanda tangan belum diisi');
                          } else {
                            submitAbsen(rapatData.idAgenda);
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
            Container(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );

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

  Widget tandaTanganForm() => primaryButton(
        text: 'TTD',
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
      );
}
