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

  static const String discover   = '/api/dramas';
  static const String dramas     = '/api/dramas';
  static const String video      = '/api/video';
  static const String search     = '/api/search';
  static const String categories = '/api/categories';
  static const String languages  = '/api/languages';
  static const String detail     = '/api/detail';
  static const String keyStatus  = '/api/ping';
  static const String home       = '/api/home';
  static const String banner     = '/api/banner';
}
