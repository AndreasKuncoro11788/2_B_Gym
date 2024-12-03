import 'package:flutter/material.dart';

Widget inputForm(
  String? Function(String?)? validator, {
  required TextEditingController controller,
  required String hintTxt,
  required String helperTxt,
  required IconData iconData,
  bool password = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      obscureText: password,
      decoration: InputDecoration(
        labelText: hintTxt,
        hintText: helperTxt,
        prefixIcon: Icon(iconData, color: Colors.pink),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.pink),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.pink, width: 2),
        ),
      ),
      validator: validator,
    ),
  );
}