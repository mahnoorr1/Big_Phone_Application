import 'package:flutter/material.dart';

class ThemeDataStyle {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.grey.shade100,
      primary: Colors.black,
      secondary: Colors.deepPurple,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 44, 44, 44),
      primary: Colors.white,
      secondary: Color.fromARGB(255, 179, 157, 219),
    ),
  );
}
