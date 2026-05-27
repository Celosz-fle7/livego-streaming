import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class DracinEngine {
  static const String baseUrl =
      'https://livegoo.ashtertimur.workers.dev';

  static const Duration timeout = Duration(seconds: 15);

  // =========================
  // MAIN REQUEST
  // =========================

  static Future<Map<String, dynamic>?> get(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    try {
      final uri = Uri.parse(
        '$baseUrl$endpoint',
      ).replace(
        queryParameters: _cleanParams(params),
      );

      debugPrint('🌐 DRACIN GET → $uri');

      final response = await http
          .get(
            uri,
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          )
          .timeout(timeout);

      debugPrint('📥 STATUS → ${response.statusCode}');

      if (response.statusCode != 200) {
        return _error(
          'HTTP ${response.statusCode}',
        );
      }

      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        return _normalize(decoded);
      }

      if (decoded is List) {
        return {
          'success': true,
          'data': decoded,
        };
      }

      return _error('Invalid response');
    } catch (e) {
      debugPrint('❌ DRACIN ERROR → $e');
      return _error(e.toString());
    }
  }

  // =========================
  // STANDARD ENDPOINTS
  // =========================

  static Future<Map<String, dynamic>?> discover({
    required String platform,
  }) {
    return get(
      '/api/dramas',
      params: {
        'platform': platform,
        'lang': 'id',
      },
    );
  }

  static Future<Map<String, dynamic>?> search({
    required String platform,
    required String query,
  }) {
    return get(
      '/api/search',
      params: {
        'platform': platform,
        'q': query,
      },
    );
  }

  static Future<Map<String, dynamic>?> detail({
    required String id,
    required String platform,
  }) {
    return get(
      '/api/detail',
      params: {
        'id': id,
        'platform': platform,
      },
    );
  }

  static Future<Map<String, dynamic>?> video({
    required String id,
    required String platform,
    int episode = 1,
  }) {
    return get(
      '/api/video',
      params: {
        'id': id,
        'platform': platform,
        'chapter': episode.toString(),
      },
    );
  }

  // =========================
  // NORMALIZER
  // =========================

  static Map<String, dynamic> _normalize(
    Map<String, dynamic> raw,
  ) {
    return {
      'success': raw['success'] ?? true,
      'platform': raw['platform'],
      'data': raw['data'],
      'dramas': raw['dramas'],
      'message': raw['message'],
    };
  }

  // =========================
  // HELPERS
  // =========================

  static Map<String, String> _cleanParams(
    Map<String, dynamic>? params,
  ) {
    final map = <String, String>{};

    if (params == null) return map;

    params.forEach((key, value) {
      if (value != null) {
        map[key] = value.toString();
      }
    });

    return map;
  }

  static Map<String, dynamic> _error(
    String message,
  ) {
    return {
      'success': false,
      'message': message,
    };
  }
}
