// lib/utils/theme.dart
// OPTIMIZED VERSION

import 'package:flutter/material.dart';

class LiveGOCopilotTheme {
  // Warna utama GitHub Copilot
  static const Color background = Color(0xFF0D1117);
  static const Color surface = Color(0xFF161B22);
  static const Color surfaceLight = Color(0xFF21262D);
  
  // Warna aksen
  static const Color cyan = Color(0xFF04D2FF);
  static const Color blue = Color(0xFF027DFD);
  static const Color purple = Color(0xFF9D4EDD);
  
  // Warna text
  static const Color textPrimary = Color(0xFFE6EDF3);
  static const Color textSecondary = Color(0xFF8B949E);
  static const Color textMuted = Color(0xFF6E7681);
  
  // Warna status
  static const Color success = Color(0xFF2DA44E);
  static const Color warning = Color(0xFFD29922);
  static const Color error = Color(0xFFF85149);
  
  // Gradient untuk elemen premium
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [cyan, blue, purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF161B22), Color(0xFF1A2332)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // 🔥 Responsive font size untuk TV vs Mobile
  static double _getFontScale(bool isTV) => isTV ? 1.2 : 1.0;
  
  static ThemeData getTheme(bool isTV) {
    final fontScale = _getFontScale(isTV);
    
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: cyan,
      colorScheme: const ColorScheme.dark(
        primary: cyan,
        secondary: blue,
        tertiary: purple,
        surface: surface,
        background: background,
        error: error,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: cyan,
        unselectedItemColor: textMuted,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: surfaceLight, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: surfaceLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: surfaceLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: cyan, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cyan,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      // 🔥 Text theme dengan font scale responsif
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: textPrimary,
          fontSize: 28 * fontScale,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 24 * fontScale,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 20 * fontScale,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: textPrimary,
          fontSize: 16 * fontScale,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 14 * fontScale,
        ),
        bodySmall: TextStyle(
          color: textMuted,
          fontSize: 12 * fontScale,
        ),
      ),
    );
  }
}

// 🔥 Extension untuk mudah akses theme di widget
extension LiveGOThemeExtension on BuildContext {
  LiveGOCopilotThemeType get livego => LiveGOCopilotThemeType(this);
}

class LiveGOCopilotThemeType {
  final BuildContext context;
  LiveGOCopilotThemeType(this.context);
  
  Color get background => LiveGOCopilotTheme.background;
  Color get surface => LiveGOCopilotTheme.surface;
  Color get surfaceLight => LiveGOCopilotTheme.surfaceLight;
  Color get cyan => LiveGOCopilotTheme.cyan;
  Color get blue => LiveGOCopilotTheme.blue;
  Color get purple => LiveGOCopilotTheme.purple;
  Color get textPrimary => LiveGOCopilotTheme.textPrimary;
  Color get textSecondary => LiveGOCopilotTheme.textSecondary;
  Color get textMuted => LiveGOCopilotTheme.textMuted;
  Color get success => LiveGOCopilotTheme.success;
  Color get warning => LiveGOCopilotTheme.warning;
  Color get error => LiveGOCopilotTheme.error;
  
  LinearGradient get premiumGradient => LiveGOCopilotTheme.premiumGradient;
  LinearGradient get cardGradient => LiveGOCopilotTheme.cardGradient;
  
  // Helper untuk spacing
  EdgeInsets get defaultPadding => const EdgeInsets.all(16);
  EdgeInsets get smallPadding => const EdgeInsets.all(8);
  EdgeInsets get horizontalPadding => const EdgeInsets.symmetric(horizontal: 16);
  EdgeInsets get verticalPadding => const EdgeInsets.symmetric(vertical: 12);
  
  // Border radius
  BorderRadius get defaultRadius => BorderRadius.circular(12);
  BorderRadius get smallRadius => BorderRadius.circular(8);
  BorderRadius get largeRadius => BorderRadius.circular(20);
}
