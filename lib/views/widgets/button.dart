import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';

Widget primaryButton({required String text, required Function onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: primaryColor,
    ),
    onPressed: () {
      onPressed();
    },
    child: Container(
      height: 50,
      // width: 150,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget secondaryButton({required String text, required Function onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: secondaryColor,
    ),
    onPressed: () {
      onPressed();
    },
    child: Container(
      height: 50,
      // width: 150,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}
