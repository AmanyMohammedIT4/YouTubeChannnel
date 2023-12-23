import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputDecoration(
      {required String hintext,
      required String labeltext,
      required Icon icono}) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 137, 207, 190))),
      focusedBorder: const UnderlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 137, 207, 190), width: 2)),
      hintText: hintext,
      labelText: labeltext,
      prefixIcon: icono,
    );
  }
}

class InputDecorationt {}
