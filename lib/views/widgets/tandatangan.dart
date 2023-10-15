// IMPORT PACKAGE
import 'package:signature/signature.dart';
import 'package:flutter/material.dart';

// Initialise a controller. It will contains signature points, stroke width and pen color.
// It will allow you to interact with the widget
tandaTangan() {}

/// Pushes a widget to a new route.
Future push(context, widget) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return widget;
      },
    ),
  );
}
