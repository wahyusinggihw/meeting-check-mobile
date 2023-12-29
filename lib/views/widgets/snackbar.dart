import 'package:flutter/material.dart';

successSnackbar(BuildContext context, String text, {int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue,
      content: Text(text),
      duration: Duration(seconds: duration),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

errorSnackbar(BuildContext context, String text, {int duration = 2}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(text),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
