import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meeting_check/services/login_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:meeting_check/views/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nipController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;

  @override
  Widget build(BuildContext context) {
    double currentHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(height: currentHeight / 6),
                Image.asset('assets/images/logo.png', height: 100, width: 100),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Silahkan masuk',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding: MediaQuery.of(context).size.width > 600
                          ? const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 50)
                          : const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                      child: Container(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              cursorColor: secondaryColor,
                              controller: _nipController,
                              decoration: const InputDecoration(
                                  fillColor: secondaryColor,
                                  focusColor: secondaryColor,
                                  hintText: 'NIPTT',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide:
                                          BorderSide(color: primaryColor))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan NIPTT anda';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(
                                  fillColor: secondaryColor,
                                  focusColor: secondaryColor,
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide:
                                          BorderSide(color: primaryColor))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Masukkan password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            // const Spacer(),
                            Center(
                                child: primaryButton(
                                    text: 'Masuk',
                                    onPressed: () {
                                      _login(
                                          '750119911225002', '750119911225002');
                                      // if (_formKey.currentState!.validate()) {
                                      //   String username = _nipController.text;
                                      //   String password =
                                      //       _passwordController.text;
                                      //   // _login('75010201', '75010201');
                                      // }
                                    }))
                          ],
                        ),
                      ),
                    ))
              ],
            ),
    );
  }

  void _login(String username, String password) async {
    setState(() {
      _isloading = true;
    });
    var data = {
      'username': username,
      'password': password,
    };
    var response = await LoginService().login(data);
    print(response['status']);
    if (response['status'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      Map user = response['data'];

      localStorage.setString('user', jsonEncode(user));
      localStorage.setBool('islogin', true);
      // localStorage.setString('token', response['token']);

      successSnackbar(context, response['message']);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      setState(() {
        _isloading = false;
      });
      errorSnackbar(context, response['message']);
    }
  }
}
