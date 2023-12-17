import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meeting_check/services/auth_services.dart';
import 'package:meeting_check/views/colors.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:meeting_check/views/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _changePassKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isloading = false;

  String username = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user').toString());

    if (user != null) {
      setState(() {
        username = user['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Ganti Password'),
      ),
      body: _isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 20),
                Form(
                    key: _changePassKey,
                    child: Padding(
                      padding: MediaQuery.of(context).size.width > 600
                          ? const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 50)
                          : const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            cursorColor: secondaryColor,
                            obscureText: !_isPasswordVisible,
                            controller: _passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              fillColor: secondaryColor,
                              focusColor: secondaryColor,
                              hintText: 'Password lama',
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  borderSide: BorderSide(color: primaryColor)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan password lama anda';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: !_isNewPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              fillColor: secondaryColor,
                              focusColor: secondaryColor,
                              hintText: 'Password Baru',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isNewPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isNewPasswordVisible =
                                        !_isNewPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // confirm password
                          TextFormField(
                            obscureText: !_isConfirmPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              fillColor: secondaryColor,
                              focusColor: secondaryColor,
                              hintText: 'Konfirmasi Password Baru',
                              border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: primaryColor),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isConfirmPasswordVisible =
                                        !_isConfirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Konfirmasi password';
                              } else if (value != _newPasswordController.text) {
                                return 'Password tidak sama';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          // const Spacer(),
                          Center(
                              child: primaryButton(
                                  child: const Text(
                                    'Ubah Password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    // _login(
                                    //     '750119911225002', '750119911225002');
                                    if (_changePassKey.currentState!
                                        .validate()) {
                                      String password =
                                          _passwordController.text;
                                      String newPassword =
                                          _newPasswordController.text;
                                      _changePassword(
                                          username, password, newPassword);
                                    }
                                  }))
                        ],
                      ),
                    ))
              ],
            ),
    );
  }

  void _changePassword(String username, String password, String newPassword) {
    setState(() {
      _isloading = true;
    });
    var data = {
      'username': username,
      'password': password,
      'new_password': newPassword,
    };
    print(username);
    AuthService().changePassword(data).then((val) async {
      if (val['error'] == false) {
        successSnackbar(context, val['message'], duration: 5);
        Navigator.pop(context);
      } else {
        setState(() {
          _isloading = false;
        });
        errorSnackbar(context, val['message'], duration: 5);
      }
    });
  }
}
