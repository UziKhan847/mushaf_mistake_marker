import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFFF2EB),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFFFFF9F6),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFFFF9F6),
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Color(0xFF2F2F2F)),
      titleTextStyle: const TextStyle(color: Color(0xFF2F2F2F), fontSize: 18),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF0B0D0E),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: const Color(0xFF0F1213),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF0F1213),
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Color(0xFFECECEC)),
      titleTextStyle: const TextStyle(color: Color(0xFFECECEC), fontSize: 18),
    ),
  );
}
