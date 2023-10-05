import 'package:flutter/material.dart';
import 'package:meeting_check/views/auth/login.dart';
import 'package:meeting_check/views/bottom_navbar.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/qr_screen.dart';
import 'package:meeting_check/views/detail_rapat.dart';
import 'package:meeting_check/views/qrsuccess_screen.dart';
import 'package:meeting_check/views/splash_screen.dart';
import 'package:meeting_check/views/qrerror_screen.dart';
import 'package:meeting_check/views/formdaftarhadir_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'MeetingCheck',
                ));
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/qr-screen':
        return MaterialPageRoute(
            builder: (context) => const QrScreen(), settings: settings);
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/detail-rapat':
        return MaterialPageRoute(
            builder: (context) => const DetailRapat(), settings: settings);
      case '/form-daftarhadir':
        return MaterialPageRoute(
            builder: (context) => const FormDaftarHadir(), settings: settings);
      case '/login':
        return MaterialPageRoute(
            builder: (context) => const Login(), settings: settings);
      // error
      case '/error-qr':
        return MaterialPageRoute(
            builder: (_) => const QrErrorScreen(), settings: settings);
      case '/success-qr':
        return MaterialPageRoute(
            builder: (_) => const QrSuccessScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'MeetingCheck',
                ));
    }
  }
}
