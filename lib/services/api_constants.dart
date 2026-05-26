import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  static const String baseUrl = 'https://livegoo.ashtertimur.workers.dev';

  static const String _envKey = String.fromEnvironment('DRACIN_API_KEY');
  static String _secret = '';

  static String get secret {
    if (_secret.isNotEmpty) return _secret;
    if (_envKey.isNotEmpty && _envKey != 'fallback_dev_key_livego') {
      _secret = _envKey;
      return _secret;
    }
    return '';
  }

  static bool get hasKey => secret.isNotEmpty;

  static Future<void> loadKeyFromStorage() async {
    try {
      _secret = _envKey;

      if (_secret.isNotEmpty) return;

      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('api_key') ?? '';

      if (savedKey.isNotEmpty) {
        _secret = savedKey;
      }
    } catch (_) {}
  }

  static const String discover   = '/api/v2/discover';
  static const String video      = '/api/v2/video';
  static const String search     = '/api/v2/search';
  static const String categories = '/api/v2/categories';
  static const String languages  = '/api/v2/languages';
  static const String detail     = '/api/v2/detail';
  static const String keyStatus  = '/api/v2/key/status';
  static const String home       = '/api/v2/home';
}
