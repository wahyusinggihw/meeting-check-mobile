import 'package:flutter/material.dart';
import 'package:meeting_check/views/auth/change_password.dart';
import 'package:meeting_check/views/auth/login.dart';
import 'package:meeting_check/views/bottom_navbar.dart';
import 'package:meeting_check/views/profile_screen.dart';
import 'package:meeting_check/views/qr_screen.dart';
import 'package:meeting_check/views/detail_rapat.dart';
import 'package:meeting_check/views/success_screen.dart';
import 'package:meeting_check/views/splash_screen.dart';
import 'package:meeting_check/views/error_screen.dart';
import 'package:meeting_check/views/formdaftarhadir_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'DaftarHadir',
                ));
      case '/splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/qr-screen':
        return MaterialPageRoute(
            builder: (context) => const QrScreen(), settings: settings);
      case '/profile':
        return MaterialPageRoute(
            builder: (_) => const ProfileScreen(
                  title: 'Profile',
                ));
      case '/detail-rapat':
        return MaterialPageRoute(
            builder: (context) => const DetailRapat(), settings: settings);
      case '/form-daftarhadir':
        return MaterialPageRoute(
            builder: (context) => const FormDaftarHadir(), settings: settings);
      case '/login':
        return MaterialPageRoute(
            builder: (context) => const Login(), settings: settings);
      case '/change-password':
        return MaterialPageRoute(
            builder: (context) => const ChangePassword(), settings: settings);
      // error
      case '/error':
        return MaterialPageRoute(
            builder: (_) => const ErrorScreen(), settings: settings);
      case '/success':
        return MaterialPageRoute(
            builder: (_) => const SuccessScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(
                  title: 'DaftarHadir',
                ));
    }
  }
}
