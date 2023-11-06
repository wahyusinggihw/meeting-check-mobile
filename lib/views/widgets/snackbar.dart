import 'package:flutter/material.dart';

successSnackbar(BuildContext context, String text, {int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue,
      content: Text(text),
      duration: Duration(seconds: duration),
    ),
  );
}

errorSnackbar(BuildContext context, String text, {int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}
