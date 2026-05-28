import 'package:flutter/material.dart';

class TVTheme {
  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor:
        const Color(0xFF070B12),

    fontFamily: 'Roboto',

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF04D2FF),
      secondary: Color(0xFFFF003F),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),

      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),

      bodyMedium: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    ),
  );
}
