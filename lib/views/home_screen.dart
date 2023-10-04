import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> agenda = <String>[
    'Pertemuan membahas kalender kerja kominfo tahun 2022 dan lain-lain',
    'Koordianasi dengan kepala dinas terkait',
    'Rapat koordinasi bersama sekretaris daerah',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: MediaQuery.of(context).size.width > 600
            ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
            : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agenda Rapat',
                style: Theme.of(context).textTheme.titleMedium),
            Expanded(
              child: ListView.builder(
                itemCount: agenda.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      shape: ShapeBorder.lerp(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          1),
                      onTap: () {
                        Navigator.pushNamed(context, '/detail-rapat',
                            arguments: {
                              'title': 'Detail Rapat',
                              'agenda': agenda[index]
                            });
                      },
                      leading: Icon(Icons.event_note, color: Color(0xff95989A)),
                      tileColor: Colors.white,
                      title: Text('Senin, 20 September 2021',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )),
                      subtitle: Text(
                        '${agenda[index]}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          color: Color(0xff95989A),
                          fontSize: 12,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Colors.blue, size: 15),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
