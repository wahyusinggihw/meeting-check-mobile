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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            surfaceTintColor: Colors.white,
            elevation: 8, // Atur elevasi kartu sesuai kebutuhan
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    args['agenda'].agendaRapat,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  detailRapatAgenda('Tanggal', args['agenda'].tanggal),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  detailRapatAgenda('Jam', args['agenda'].jam),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  detailRapatAgenda('Tempat', args['agenda'].tempat),
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
                        args['agenda'].deskripsi,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
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
