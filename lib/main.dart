import 'package:flutter/material.dart';
import 'package:meeting_check/routes/router.dart' as router;
// import 'package:meeting_check/views/bottom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meeting Check',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: router.RouteGenerator.generateRoute,
      // home: const MyHomePage(title: 'MeetingCheck'),
    );
  }
}
