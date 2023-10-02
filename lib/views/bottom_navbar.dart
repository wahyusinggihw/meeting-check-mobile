import 'package:flutter/material.dart';
import 'package:meeting_check/views/home_screen.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/rapat_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final screens = const [
    HomeScreen(),
    RapatScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          title: Text(widget.title),
          backgroundColor: Colors.white,
        ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            // indicatorColor: Colors.blue,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          child: NavigationBar(
            shadowColor: Colors.black.withOpacity(0.16),
            backgroundColor: Colors.white,
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.people),
                label: 'Rapat',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
