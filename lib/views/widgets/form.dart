import 'package:flutter/material.dart';
import 'package:meeting_check/views/colors.dart';

myTextFormField(TextEditingController controller,
    {String? hint, String? value, String? Function(String?)? validator}) {
  return TextFormField(
    enabled: false,
    cursorColor: secondaryColor,
    controller: controller,
    initialValue: value,
    decoration: InputDecoration(
        fillColor: secondaryColor,
        focusColor: secondaryColor,
        hintText: hint,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: primaryColor))),
    validator: validator,
  );
}

formDaftarHadir(String title, value) {
  return Container(
    height: 48,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey)),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            Text(
              title,
              // style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        Column(
          children: [
            Text(value,
                style: TextStyle(
                    color: Colors.grey[600], overflow: TextOverflow.ellipsis)),
          ],
        )
      ]),
    ),
  );
}
