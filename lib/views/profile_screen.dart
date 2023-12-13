import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/services/auth_services.dart';
import 'package:meeting_check/views/widgets/button.dart';
import 'package:provider/provider.dart';
// shared prefs
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String title;
  const ProfileScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String nip = '';
  String no = '';
  String instansi = '';

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
        name = user['nama'];
        nip = user['nip'];
        no = user['no_hp'];
        instansi = user['instansi'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AgendaRapatProvider agendaProvider =
        Provider.of<AgendaRapatProvider>(context, listen: false);
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    return Scaffold(
        body: Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // verticalDirection: VerticalDirection.up,
        children: [
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          userInfo(context, 'NIP', nip),
          userInfo(context, 'NO', no),
          userInfo(context, 'Instansi', instansi),
          const Spacer(),
          secondaryButton(
              text: 'Ganti Password',
              onPressed: () {
                Navigator.pushNamed(context, '/change-password');
              }),
          secondaryButton(
              text: 'Keluar',
              onPressed: () {
                // RapatServices().extractCode();
                AuthService().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
                agendaProvider.clearAgendaRapat();
              })
        ],
      ),
    ));
  }
}

Widget userInfo(BuildContext context, String title, String value) => Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 40)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
    Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Container(
                width: 350,
                height: 40,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ))),
                child: Row(children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            // navigateSecondPage(editPage);
                          },
                          child: Text(
                            getValue,
                            style: const TextStyle(fontSize: 16, height: 1.4),
                          ))),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  )
                ]))
          ],
        ));
