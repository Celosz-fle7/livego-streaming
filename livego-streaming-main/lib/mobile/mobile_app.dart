// lib/mobile/mobile_app.dart
// FIXED + OPTIMIZED — MobileApp dihapus, diganti pure navigator extension
// MaterialApp root sudah ada di main.dart, tidak perlu MaterialApp ganda

import 'package:flutter/material.dart';
import 'screens/player_screen.dart';
import 'screens/history_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/search_screen.dart';
import 'screens/account_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/source_manager.dart';

// ──────────────────────────────────────────────────────────
// Platform & Category config (tetap di sini karena dipakai
// oleh home_screen, source_manager, dll)
// ──────────────────────────────────────────────────────────

// Navigation Extension untuk Mobile
// 🔥 FIX: navigateToPlayer sekarang benar — route /player sudah
//    terdaftar di root MaterialApp (main.dart), jadi pushNamed berhasil.
extension MobileNavigator on BuildContext {
  void navigateToHome() {
    Navigator.pushReplacementNamed(this, '/home');
  }

  void navigateToHistory() {
    Navigator.push(
      this,
      _fadeRoute(RepaintBoundary(child: const HistoryScreen())),
    );
  }

  void navigateToFavorite() {
    Navigator.push(
      this,
      _fadeRoute(RepaintBoundary(child: const FavoriteScreen())),
    );
  }

  void navigateToSearch() {
    Navigator.push(
      this,
      _fadeRoute(RepaintBoundary(child: const SearchScreen())),
    );
  }

  void navigateToAccount() {
    Navigator.push(
      this,
      _fadeRoute(RepaintBoundary(child: const AccountScreen())),
    );
  }

  void navigateToSettings() {
    Navigator.push(
      this,
      _fadeRoute(RepaintBoundary(child: const SettingsScreen())),
    );
  }

  void navigateToSourceManager() {
    Navigator.push(
      this,
      _fadeRoute(RepaintBoundary(child: const SourceManagerPage())),
    );
  }

  // 🔥 FIX KUNCI: pushNamed ke /player yang kini terdaftar di root
  void navigateToPlayer({
    required String id,
    required String source,
    required String title,
  }) {
    Navigator.pushNamed(
      this,
      '/player',
      arguments: {
        'id': id,
        'source': source,
        'title': title,
      },
    );
  }
}

// Helper: fade transition ringan dengan RepaintBoundary
PageRoute _fadeRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, anim, __, child) =>
        FadeTransition(opacity: anim, child: child),
    transitionDuration: const Duration(milliseconds: 220),
  );
}
