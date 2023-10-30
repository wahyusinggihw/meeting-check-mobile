import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:meeting_check/services/rapat_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:meeting_check/views/widgets/form.dart';
import 'package:meeting_check/views/widgets/tandatangan.dart';
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
    RapatServices rapatServices = RapatServices();
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String kodeRapat = arguments?['kodeRapat'] ?? '';

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Form Daftar Hadir'),
        ),
        body: ListView(
          children: [
            FutureBuilder<dynamic>(
              future: rapatServices.getRapatByKode(
                  kodeRapat), // Replace 'kodeRapat' with the actual value
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No data available.');
                } else {
                  final responseData = snapshot.data!['data'];
                  // return Text('Judul Rapat: $judulRapat');
                  return Form(
                      child: Padding(
                    padding: MediaQuery.of(context).size.width > 600
                        ? const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 50)
                        : const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
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
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Judul Rapat",
                                      // style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(responseData['judul_rapat'],
                                        style:
                                            TextStyle(color: Colors.grey[600]))
                                  ]),
                            ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Jam",
                                      // style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(responseData['jam'],
                                        style:
                                            TextStyle(color: Colors.grey[600]))
                                  ]),
                            ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Tempat",
                                      // style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(responseData['tempat'],
                                        style:
                                            TextStyle(color: Colors.grey[600]))
                                  ]),
                            ),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Agenda",
                                      // style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    Text(responseData['agenda'],
                                        style:
                                            TextStyle(color: Colors.grey[600]))
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Tanda Tangan",
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
                                                        const EdgeInsets.all(
                                                            8.0),
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
                                                                      Colors
                                                                          .white),
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
                  ));
                }
              },
            ),
            // FutureBuilder(
            //     future: rapatServices.getRapatByKode(kodeRapat),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return Center(child: CircularProgressIndicator());
            //       } else if (snapshot.hasError) {
            //         return Text('Error: ${snapshot.error}');
            //       } else {
            // final judulRapat = snapshot['data']['judul_rapat'];
            // Handle the API response in the UI
            // return Text('Data from API: ${snapshot.data}');
            // return Form(
            //   child: Padding(
            //     padding: MediaQuery.of(context).size.width > 600
            //         ? const EdgeInsets.symmetric(
            //             horizontal: 100, vertical: 50)
            //         : const EdgeInsets.symmetric(
            //             horizontal: 20, vertical: 20),
            //     child: Form(
            //       key: _formKey,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('Agenda Rapat',
            //               style:
            //                   Theme.of(context).textTheme.titleMedium),
            //           const SizedBox(height: 20),
            //           TextFormField(
            //             // controller: _nipController,
            //             // access the object
            //             initialValue: snapshot['data']['judul_rapat'],
            //             // initialValue: '${snapshot.data!{'kode_rapat'}}}',
            //             enabled: false,
            //             decoration: const InputDecoration(
            //                 fillColor: secondaryColor,
            //                 focusColor: secondaryColor,
            //                 hintText: 'NIPTT',
            //                 border: OutlineInputBorder(
            //                     borderRadius: BorderRadius.all(
            //                         Radius.circular(15))),
            //                 focusedBorder: OutlineInputBorder(
            //                     borderRadius: BorderRadius.all(
            //                         Radius.circular(15)),
            //                     borderSide:
            //                         BorderSide(color: primaryColor))),
            //             validator: (value) {
            //               if (value == null || value.isEmpty) {
            //                 return 'Masukkan NIPTT anda';
            //               }
            //               return null;
            //             },
            //           ),
            //           const SizedBox(height: 10),
            //           Container(
            //             height: 48,
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(15),
            //                 border: Border.all(color: Colors.grey)),
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       "NIPTT",
            //                       style: TextStyle(
            //                           color: Colors.grey[600]),
            //                     ),
            //                     Text("1234567890",
            //                         style: TextStyle(
            //                             color: Colors.grey[600]))
            //                   ]),
            //             ),
            //           ),
            //           const SizedBox(height: 10),
            //           Container(
            //             height: 48,
            //             decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(15),
            //                 border: Border.all(color: primaryColor)),
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Row(
            //                   mainAxisAlignment:
            //                       MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Text(
            //                       "Tanda Tangan",
            //                       style: TextStyle(
            //                           color: Colors.grey[600]),
            //                     ),
            //                     IconButton(
            //                         onPressed: () {
            //                           showDialog(
            //                               context: context,
            //                               builder:
            //                                   (BuildContext context) {
            //                                 return AlertDialog(
            //                                   actionsAlignment:
            //                                       MainAxisAlignment
            //                                           .center,
            //                                   backgroundColor:
            //                                       Colors.white,
            //                                   scrollable: true,
            //                                   title:
            //                                       Text('Tanda Tangan'),
            //                                   content: Padding(
            //                                     padding:
            //                                         const EdgeInsets
            //                                             .all(8.0),
            //                                     child: Form(
            //                                       child: Column(
            //                                         children: <Widget>[
            //                                           Stack(
            //                                             alignment:
            //                                                 AlignmentDirectional
            //                                                     .topEnd,
            //                                             children: [
            //                                               Signature(
            //                                                   controller:
            //                                                       _controller,
            //                                                   width:
            //                                                       200,
            //                                                   height:
            //                                                       200,
            //                                                   backgroundColor:
            //                                                       Colors
            //                                                           .white),
            //                                               IconButton(
            //                                                   onPressed: () =>
            //                                                       _controller
            //                                                           .clear(),
            //                                                   icon: const Icon(
            //                                                       Icons
            //                                                           .delete)),
            //                                             ],
            //                                           ),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                   ),
            //                                   actions: [
            //                                     primaryButton(
            //                                         text: "Submit",
            //                                         onPressed:
            //                                             () async {
            //                                           exportImage(
            //                                               context);
            //                                         })
            //                                   ],
            //                                 );
            //                               });
            //                         },
            //                         icon: Icon(
            //                           Icons.create,
            //                           color: primaryColor,
            //                           size: 20,
            //                         ))
            //                   ]),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // );
            // }
            // }),
          ],
        ));
  }

  getAgendaRapat(kodeRapat) async {
    RapatServices rapatServices = RapatServices();
    var data = await rapatServices.getRapatByKode(kodeRapat);
    print('dari form:' + data);
  }
}
