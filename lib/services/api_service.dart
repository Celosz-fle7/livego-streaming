import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

class ApiService {
  static const String _cachePrefix = 'api_cache_';
  static const int _cacheTtlSeconds = 300;

  static Future<Map<String, dynamic>?> get(String path, {bool forceRefresh = false}) async {
    final url = '${ApiConstants.baseUrl}$path';
    final cacheKey = '$_cachePrefix$url';

    try {
      final res = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 15));

      if (res.statusCode != 200) return null;

      final decoded = jsonDecode(res.body);

      if (decoded is Map<String, dynamic>) {
        return decoded;
      }

      if (decoded is List) {
        return {'data': decoded};
      }

      return null;
    } catch (_) {
      return null;
    }
  }

  static List safeList(Map<String, dynamic>? res) {
    if (res == null) return [];
    final data = res['data'] ?? res['dramas'] ?? res['results'];
    return data is List ? data : [];
  }
}
