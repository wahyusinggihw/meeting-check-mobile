import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 50)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        // verticalDirection: VerticalDirection.up,
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/images.jpg'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 22,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          userInfo(context, 'NIP', '199205142023052008'),
          userInfo(context, 'NO', '082123456789'),
          userInfo(context, 'Instansi', 'Kominfosanti'),
          Spacer(),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(secondaryColor),
              ),
              onPressed: () {},
              child: Container(
                width: 100,
                alignment: Alignment.center,
                child: const Text(
                  'Keluar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ))
        ],
      ),
    ));
  }
}

Widget userInfo(context, String title, String value) => Padding(
      padding: MediaQuery.of(context).size.width > 600
          ? const EdgeInsets.symmetric(horizontal: 100, vertical: 40)
          : const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 1,
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  // Text(':'),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
    Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
                width: 350,
                height: 40,
                decoration: BoxDecoration(
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
                            style: TextStyle(fontSize: 16, height: 1.4),
                          ))),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 40.0,
                  )
                ]))
          ],
        ));
