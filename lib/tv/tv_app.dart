// lib/tv/tv_app.dart
// LIVEGO TV - MAIN APP WITH ROUTING
// Full TV Optimization

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/player_screen.dart';
import 'screens/history_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/search_screen.dart';
import 'screens/account_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/source_manager_screen.dart';

class TVApp extends StatelessWidget {
  const TVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LiveGO TV',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D111A),
        primaryColor: const Color(0xFF06B6D4),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF06B6D4),
          secondary: Color(0xFF06B6D4),
        ),
        visualDensity: VisualDensity.standard,
        useMaterial3: true,
      ),
      home: const TVHomeScreen(),
      onGenerateRoute: _generateRoute,
    );
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case '/tv_home':
        return _buildPageRoute(const TVHomeScreen(), settings);
      case '/tv_history':
        return _buildPageRoute(const TVHistoryScreen(), settings);
      case '/tv_favorite':
        return _buildPageRoute(const TVFavoriteScreen(), settings);
      case '/tv_search':
        return _buildPageRoute(const TVSearchScreen(), settings);
      case '/tv_account':
        return _buildPageRoute(const TVAccountScreen(), settings);
      case '/tv_settings':
        return _buildPageRoute(const TVSettingsScreen(), settings);
      case '/tv_source_manager':
        return _buildPageRoute(const TVSourceManagerScreen(), settings);
      case '/tv_player':
        final args = settings.arguments as Map<String, String>?;
        if (args != null) {
          return _buildPageRoute(
            TVPlayerScreen(
              id: args['id'] ?? '',
              source: args['source'] ?? '',
              title: args['title'] ?? '',
            ),
            settings,
          );
        }
        return null;
      default:
        return null;
    }
  }

  PageRoute _buildPageRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var opacityAnimation = animation.drive(tween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      reverseTransitionDuration: const Duration(milliseconds: 150),
    );
  }
}

// ═══════════════════ NAVIGATOR EXTENSION ═══════════════════
extension TVNavigator on BuildContext {
  void navigateToTVHome() {
    Navigator.pushReplacementNamed(this, '/tv_home');
  }

  void navigateToTVHistory() {
    Navigator.pushNamed(this, '/tv_history');
  }

  void navigateToTVFavorite() {
    Navigator.pushNamed(this, '/tv_favorite');
  }

  void navigateToTVSearch() {
    Navigator.pushNamed(this, '/tv_search');
  }

  void navigateToTVAccount() {
    Navigator.pushNamed(this, '/tv_account');
  }

  void navigateToTVSettings() {
    Navigator.pushNamed(this, '/tv_settings');
  }

  void navigateToTVSourceManager() {
    Navigator.pushNamed(this, '/tv_source_manager');
  }

  void navigateToTVPlayer({
    required String id,
    required String source,
    required String title,
  }) {
    Navigator.pushNamed(
      this,
      '/tv_player',
      arguments: {
        'id': id,
        'source': source,
        'title': title,
      },
    );
  }
}
