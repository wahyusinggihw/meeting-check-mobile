import 'package:flutter/material.dart';

class RapatScreen extends StatelessWidget {
  const RapatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/scanqr');
            },
            child: Container(
              child: const Text('Scan QR'),
            ),
          ),
        ],
      ),
    ));
  }
}
