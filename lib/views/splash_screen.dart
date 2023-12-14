import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    isLogin();
  }

  void isLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool? isLogin = localStorage.getBool('islogin') ?? false;

    if (isLogin) {
      Timer(const Duration(milliseconds: 1000), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
      });
    } else {
      Timer(const Duration(milliseconds: 1000), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo-2.png',
            width: 170,
          ),
          const SizedBox(height: 20),
          const Text('Aplikasi Presensi',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: secondaryColor,
              )),
          const Text('Daftar Hadir',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              )),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const CircularProgressIndicator(),
          // build number version
          const SizedBox(height: 20),
          const Text('v1.0.0',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primaryColor,
              )),
        ],
      )),
    );
  }
}
