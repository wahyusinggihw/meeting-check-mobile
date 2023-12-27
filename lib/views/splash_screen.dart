import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    bool? isLogin = localStorage.getBool('islogin') ?? false;

    if (isLogin) {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/',
          (route) => false,
        );
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      });
    }
  }

  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
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
            'assets/images/icon.png',
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
        ],
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Text(
          textAlign: TextAlign.center,
          'V ${_packageInfo.version}',
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
