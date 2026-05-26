// lib/services/api_constants.dart
// FINAL VERSION - Cloudflare Worker

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiConstants {
  // 🔥 INI YANG PENTING - Cloudflare Worker URL
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
    if (_envKey.isNotEmpty && _envKey != 'fallback_dev_key_livego') {
      _secret = _envKey;
      debugPrint('✅ API Key dari ENV (${_secret.length} karakter)');
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('api_key') ?? '';
      if (savedKey.isNotEmpty) {
        _secret = savedKey;
        debugPrint('✅ API Key dari Storage (${_secret.length} karakter)');
        return;
      }
    } catch (_) {}
    debugPrint('⚠️ API KEY KOSONG! Konten mungkin tidak muncul.');
  }

  // Endpoint yang dipakai Worker (tetap)
  static const String discover   = '/api/v2/discover';
  static const String video      = '/api/v2/video';
  static const String search     = '/api/v2/search';
  static const String categories = '/api/v2/categories';
  static const String languages  = '/api/v2/languages';
  static const String detail     = '/api/v2/detail';
  static const String keyStatus  = '/api/v2/key/status';
  static const String home       = '/api/v2/home';

  static const String defaultLang     = 'id';
  static const String defaultCategory = 'freereels';
  static const String defaultSort     = 'desc';
}
