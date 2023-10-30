import 'package:flutter/material.dart';

class DetailRapat extends StatefulWidget {
  const DetailRapat({super.key});

  @override
  State<DetailRapat> createState() => _DetailRapatState();
}

class _DetailRapatState extends State<DetailRapat> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Detail Rapat'),
      ),
      body: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Center(
          child: Text(args['agenda']),
        ),
      ),
    );
  }
}
