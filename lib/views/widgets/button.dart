import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';

Widget primaryButton({required String text, required Function onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: primaryColor,
    ),
    onPressed: () {
      onPressed();
    },
    child: Container(
      width: 100,
      alignment: Alignment.bottomCenter,
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

Widget secondaryButton({required String text, required Function onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: secondaryColor,
    ),
    onPressed: () {
      onPressed();
    },
    child: Container(
      width: 100,
      alignment: Alignment.bottomCenter,
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
