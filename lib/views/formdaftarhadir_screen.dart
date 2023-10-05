import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:meeting_check/views/widgets/form.dart';
import 'package:signature/signature.dart';

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

    // await push(
    //   context,
    //   Scaffold(
    //     appBar: AppBar(
    //       title: const Text('PNG Image'),
    //     ),
    //     body: Center(
    //       child: Container(
    //         color: Colors.grey[300],
    //         child: Image.memory(data),
    //       ),
    //     ),
    //   ),
    // );

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Form Daftar Hadir'),
        ),
        body: ListView(
          children: [
            Form(
              child: Padding(
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
                      TextFormField(
                        // controller: _nipController,
                        initialValue: '1234567890',
                        enabled: false,
                        decoration: const InputDecoration(
                            fillColor: secondaryColor,
                            focusColor: secondaryColor,
                            hintText: 'NIPTT',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: primaryColor))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukkan NIPTT anda';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "NIPTT",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Text("1234567890",
                                    style: TextStyle(color: Colors.grey[600]))
                              ]),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 48,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: primaryColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Tanda Tangan",
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              actionsAlignment:
                                                  MainAxisAlignment.center,
                                              backgroundColor: Colors.white,
                                              scrollable: true,
                                              title: Text('Tanda Tangan'),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Form(
                                                  child: Column(
                                                    children: <Widget>[
                                                      Stack(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .topEnd,
                                                        children: [
                                                          Signature(
                                                              controller:
                                                                  _controller,
                                                              width: 200,
                                                              height: 200,
                                                              backgroundColor:
                                                                  Colors.white),
                                                          IconButton(
                                                              onPressed: () =>
                                                                  _controller
                                                                      .clear(),
                                                              icon: const Icon(
                                                                  Icons
                                                                      .delete)),
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
                                                      exportImage(context);
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
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
