import 'package:flutter/material.dart';
import 'package:meeting_check/views/bottom_navbar.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/qr_screen.dart';
import 'package:meeting_check/views/detail_rapat.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'MeetingCheck',
                ));
      case '/rapat':
        return MaterialPageRoute(builder: (_) => const QrScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/detail-rapat':
        return MaterialPageRoute(
            builder: (context) => const DetailRapat(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'MeetingCheck',
                ));
    }
  }
}
