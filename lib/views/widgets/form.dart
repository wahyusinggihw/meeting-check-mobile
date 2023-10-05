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
