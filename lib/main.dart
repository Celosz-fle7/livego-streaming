// lib/main.dart
// LIVEGO - MAIN APP (TV + MOBILE ROUTING FINAL)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/booting_screen.dart';
import 'utils/theme.dart';
import 'mobile/screens/player_screen.dart' as mobile;
import 'mobile/screens/main_wrapper.dart';
import 'tv/screens/home_screen.dart';
import 'tv/screens/player_screen.dart' as tv;
import 'tv/screens/search_screen.dart';
import 'tv/screens/favorite_screen.dart';
import 'tv/screens/history_screen.dart';
import 'tv/screens/account_screen.dart';
import 'tv/screens/settings_screen.dart';
import 'tv/screens/source_manager_screen.dart';
import 'services/api_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load API key (fallback dari storage kalau env kosong)
  await ApiConstants.loadKeyFromStorage();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);

  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('Flutter Error: ${details.exception}');
  };

  runApp(const LiveGOApp());
}

class LiveGOApp extends StatelessWidget {
  const LiveGOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LiveGO',
      theme: LiveGOCopilotTheme.getTheme(false),
      builder: (context, child) {
        return RepaintBoundary(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: child!,
          ),
        );
      },
      // Booting screen — auto detect TV vs Mobile
      home: const LiveGoBootingScreen(),
      
      // Semua route terdaftar di sini
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    // ═══════════════════ ROUTES ═══════════════════
    switch (settings.name) {
      
      // ── MOBILE ──────────────────────────────────
      case '/':
      case '/home':
        return _fade(const MobileMainWrapper(), settings);

      case '/player':
        final args = settings.arguments as Map<String, String>?;
        if (args != null) {
          return _fade(
            RepaintBoundary(
              child: mobile.PlayerScreen(
                title: args['title'] ?? '',
              ),
            ),
            settings,
          );
        }
        return null;

      // ── TV ──────────────────────────────────────
      case '/tv_home':
        return _fade(const TVHomeScreen(), settings);

      case '/tv_player':
        final args = settings.arguments as Map<String, String>?;
        if (args != null) {
          return _fade(
            tv.TVPlayerScreen(id: args['id'] ?? '',
              title: args['title'] ?? '',
            ),
            settings,
          );
        }
        return null;

      case '/tv_search':
        return _fade(const TVSearchScreen(), settings);

      case '/tv_favorite':
        return _fade(const TVFavoriteScreen(), settings);

      case '/tv_history':
        return _fade(const TVHistoryScreen(), settings);

      case '/tv_account':
        return _fade(const TVAccountScreen(), settings);

      case '/tv_settings':
        return _fade(const TVSettingsScreen(), settings);

      case '/tv_source_manager':
        return _fade(const TVSourceManagerScreen(), settings);

      default:
        return null;
    }
  }

  PageRoute _fade(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, anim, __, child) =>
          FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 250),
    );
  }
}
