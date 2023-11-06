import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meeting_check/views/auth/login.dart';
import 'package:meeting_check/views/bottom_navbar.dart';
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
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isLogin = sp.getBool('islogin') ?? false;

    if (isLogin) {
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyHomePage(
                      title: 'DaftarHadir',
                    )));
      });
    } else {
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
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
            'assets/images/logo.png',
            width: 200,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const CircularProgressIndicator(),
        ],
      )),
    );
  }
}
