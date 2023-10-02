import 'package:flutter/material.dart';
import 'package:meeting_check/views/bottom_navbar.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/rapat_screen.dart';
import 'package:meeting_check/views/scan_qr.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'MeetingCheck',
                ));
      case '/rapat':
        return MaterialPageRoute(builder: (_) => const RapatScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/scanqr':
        return MaterialPageRoute(builder: (_) => const ScanQr());
      default:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'MeetingCheck',
                ));
    }
  }
}
