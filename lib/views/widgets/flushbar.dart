import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

successFlushbar(BuildContext context, String message,
    {Duration duration = const Duration(seconds: 3)}) {
  return Flushbar(
    // title: "Success",
    message: message,
    duration: duration,
    icon: const Icon(
      Icons.check,
      color: Colors.white,
    ),
    animationDuration: const Duration(milliseconds: 200),
    backgroundColor: Colors.blue,
    flushbarPosition: FlushbarPosition.TOP,
    isDismissible: false,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
  ).show(context);
}

errorFlushbar(BuildContext context, String message,
    {Duration duration = const Duration(seconds: 3)}) {
  return Flushbar(
    // title: "Error",
    message: message,
    duration: duration,
    icon: const Icon(
      Icons.error,
      color: Colors.white,
    ),
    animationDuration: const Duration(milliseconds: 200),
    backgroundColor: Colors.red,
    flushbarPosition: FlushbarPosition.TOP,
    isDismissible: false,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
  ).show(context);
}
