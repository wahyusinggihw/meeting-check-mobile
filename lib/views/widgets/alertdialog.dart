import 'package:flutter/material.dart';

errorDialog(
  BuildContext context,
  String title,
  String content,
) =>
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: <Widget>[
            const Icon(
              Icons.error_outline, // You can change this to a different icon
              color: Colors.red, // Set the color of the icon
            ),
            const SizedBox(
                width: 8), // Add some spacing between the icon and text
            Text(title),
          ],
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
