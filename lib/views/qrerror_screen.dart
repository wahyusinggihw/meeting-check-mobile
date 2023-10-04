import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';

class QrErrorScreen extends StatelessWidget {
  const QrErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

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
        title: const Text('MeetingCheck'),
      ),
      body: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              child: const Icon(
                Icons.error,
                size: 100,
                color: Colors.red,
              ),
            ),
            const Text(
              'Gagal',
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Text(args['status']),
            Spacer(),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(secondaryColor),
                ),
                onPressed: () => Navigator.pop(context),
                child: Container(
                  width: 100,
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Keluar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ))
          ],
        )),
      ),
    );
  }
}
