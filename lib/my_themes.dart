import 'package:flutter/material.dart';

class MyThemes {
  static final ColorScheme lightScheme = .fromSeed(
    seedColor: const Color(0xFFae8b4f),
    brightness: .light,
  );
  static final ColorScheme darkScheme = .fromSeed(
    seedColor: const Color(0xFFae8b4f),
    brightness: .dark,
  );

  static ThemeData get lightTheme => ThemeData(
    colorScheme: lightScheme,
    brightness: .light,
    useMaterial3: true,
  );
  static ThemeData get darkTheme =>
      ThemeData(colorScheme: darkScheme, brightness: .dark, useMaterial3: true);
}
