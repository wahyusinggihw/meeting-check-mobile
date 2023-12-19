import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:meeting_check/providers/agendarapat_provider.dart';
import 'package:meeting_check/services/auth_services.dart';
import 'package:meeting_check/views/colors.dart';
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
  ScrollController scrollController = ScrollController();
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
    var height = MediaQuery.of(context).size.height;
    AgendaRapatProvider agendaProvider =
        Provider.of<AgendaRapatProvider>(context, listen: false);
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        centerTitle: false,
        title: const Text('Profil Saya'),
      ),
      backgroundColor: primaryColor,
      body: height > 600
          ? SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height / 1.5,
                      ),
                      // height: MediaQuery.of(context).size.height,
                      // height: MediaQuery.of(context).size.height * 0.7,
                      // padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: MediaQuery.of(context).size.width > 600
                            ? const EdgeInsets.fromLTRB(100, 30, 100, 0)
                            : const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // verticalDirection: VerticalDirection.up,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Center(
                              child: Text(
                                name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: textColor,
                                  fontWeight: FontWeight.w600,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            userInfo(context, 'NIP/NIPT', nip),
                            userInfo(context, 'Instansi', instansi),
                            userInfo(context, 'No.Hp', no),
                            const SizedBox(
                              height: 30,
                            ),
                            // secondaryButton(
                            //     text: 'Ganti Password',
                            //     onPressed: () {
                            //       Navigator.pushNamed(context, '/change-password');
                            //     }),
                            primaryButton(
                                child: const Text(
                                  "Keluar",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  // RapatServices().extractCode();
                                  AuthService().logout();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login', (route) => false);
                                  agendaProvider.clearAgendaRapat();
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/avatar.jpg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              controller: scrollController,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height / 1.5,
                      ),
                      // height: MediaQuery.of(context).size.height,
                      // height: MediaQuery.of(context).size.height * 0.7,
                      // padding: EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: MediaQuery.of(context).size.width > 600
                            ? const EdgeInsets.fromLTRB(100, 30, 100, 0)
                            : const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          // verticalDirection: VerticalDirection.up,
                          children: [
                            const SizedBox(
                              height: 80,
                            ),
                            Center(
                              child: Text(
                                name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            userInfo(context, 'NIP/NIPT', nip),
                            userInfo(context, 'Instansi', instansi),
                            userInfo(context, 'No. Hp', no),
                            const SizedBox(
                              height: 30,
                            ),
                            // secondaryButton(
                            //     text: 'Ganti Password',
                            //     onPressed: () {
                            //       Navigator.pushNamed(context, '/change-password');
                            //     }),
                            primaryButton(
                                child: const Text(
                                  'Keluar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  // RapatServices().extractCode();
                                  AuthService().logout();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/login', (route) => false);
                                  agendaProvider.clearAgendaRapat();
                                }),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/avatar.jpg'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

Widget userInfo(BuildContext context, String title, String value) => Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1), // Adjust the column width as needed
          1: FlexColumnWidth(1), // Adjust the column width as needed
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: primaryColor
                            // color: Colors.grey,
                            ),
                      ),
                      // const SizedBox(height: 8),
                      Text(
                        value,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                          color: secondaryColor,
                          // overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
