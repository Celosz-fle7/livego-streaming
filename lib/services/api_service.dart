// lib/services/api_service.dart
// FINAL - ApiService Cloudflare Worker ready

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

class ServerStatus {
  final bool isOnline;
  final int latencyMs;
  final String statusText;
  final String colorLabel;
  final DateTime checkedAt;

  const ServerStatus({
    required this.isOnline,
    required this.latencyMs,
    required this.statusText,
    required this.colorLabel,
    required this.checkedAt,
  });

  factory ServerStatus.fromCheck({
    required bool isOnline,
    required int latencyMs,
  }) {
    if (!isOnline) {
      return ServerStatus(
        isOnline: false,
        latencyMs: latencyMs,
        statusText: 'Server offline',
        colorLabel: 'red',
        checkedAt: DateTime.now(),
      );
    }

    if (latencyMs < 500) {
      return ServerStatus(
        isOnline: true,
        latencyMs: latencyMs,
        statusText: 'Online · ${latencyMs}ms',
        colorLabel: 'green',
        checkedAt: DateTime.now(),
      );
    }

    if (latencyMs < 1500) {
      return ServerStatus(
        isOnline: true,
        latencyMs: latencyMs,
        statusText: 'Lambat · ${latencyMs}ms',
        colorLabel: 'yellow',
        checkedAt: DateTime.now(),
      );
    }

    return ServerStatus(
      isOnline: true,
      latencyMs: latencyMs,
      statusText: 'Sangat lambat · ${latencyMs}ms',
      colorLabel: 'red',
      checkedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'isOnline': isOnline,
        'latencyMs': latencyMs,
        'statusText': statusText,
        'colorLabel': colorLabel,
        'checkedAt': checkedAt.millisecondsSinceEpoch,
      };

  factory ServerStatus.fromJson(Map<String, dynamic> json) {
    return ServerStatus(
      isOnline: json['isOnline'] == true,
      latencyMs: json['latencyMs'] is int ? json['latencyMs'] : 0,
      statusText: '${json['statusText'] ?? ''}',
      colorLabel: '${json['colorLabel'] ?? 'red'}',
      checkedAt: DateTime.fromMillisecondsSinceEpoch(
        json['checkedAt'] is int ? json['checkedAt'] : 0,
      ),
    );
  }
}

class ApiService {
  static const String _cachePrefix = 'api_cache_v2_';
  static const String _serverStatusKey = 'server_status_last';
  static const int _cacheTtlSeconds = 120;

  static Future<Map<String, dynamic>?> get(
    String path, {
    bool forceRefresh = false,
  }) async {
    final url = '${ApiConstants.baseUrl}$path';
    final cacheKey = '$_cachePrefix${path.hashCode}';

    if (!forceRefresh) {
      final cached = await _readCache(cacheKey);
      if (cached != null) {
        debugPrint('🟡 CACHE HIT: $path');
        return cached;
      }
    }

    try {
      final response = await http
          .get(
            Uri.parse(url),
            headers: const {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 20));

      debugPrint('🌐 URL: $url');
      debugPrint('📥 STATUS: ${response.statusCode}');

      final previewLength = response.body.length > 500 ? 500 : response.body.length;
      debugPrint('📦 BODY: ${response.body.substring(0, previewLength)}');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          await _writeCache(cacheKey, decoded);
          return decoded;
        }

        if (decoded is List) {
          final wrapped = {
            'success': true,
            'data': decoded,
            'dramas': decoded,
          };
          await _writeCache(cacheKey, wrapped);
          return wrapped;
        }
      }

      debugPrint('❌ HTTP ERROR: ${response.statusCode}');
    } catch (e, s) {
      debugPrint('❌ ApiService.get error: $path → $e');
      debugPrintStack(stackTrace: s);
    }

    return null;
  }

  static Future<ServerStatus> checkServerStatus() async {
    final url = '${ApiConstants.baseUrl}/api/ping';

    try {
      final sw = Stopwatch()..start();
      final res = await http.get(Uri.parse(url)).timeout(
            const Duration(seconds: 8),
          );
      sw.stop();

      debugPrint('🏓 PING URL: $url');
      debugPrint('🏓 PING STATUS: ${res.statusCode}');

      final status = ServerStatus.fromCheck(
        isOnline: res.statusCode >= 200 && res.statusCode < 300,
        latencyMs: sw.elapsedMilliseconds,
      );

      await _saveServerStatus(status);
      return status;
    } catch (e) {
      debugPrint('❌ PING ERROR: $e');
      final status = ServerStatus.fromCheck(
        isOnline: false,
        latencyMs: 0,
      );
      await _saveServerStatus(status);
      return status;
    }
  }

  static Future<ServerStatus?> getLastServerStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_serverStatusKey);
      if (raw == null) return null;
      return ServerStatus.fromJson(jsonDecode(raw));
    } catch (_) {
      return null;
    }
  }

  static Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((k) => k.startsWith('api_cache_')).toList();

      for (final key in keys) {
        await prefs.remove(key);
      }

      debugPrint('🗑️ Cache cleared: ${keys.length} entries');
    } catch (e) {
      debugPrint('❌ clearAllCache error: $e');
    }
  }

  static Future<Map<String, dynamic>?> _readCache(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(key);
      if (raw == null) return null;

      final parsed = jsonDecode(raw);
      if (parsed is! Map<String, dynamic>) return null;

      final ts = parsed['_ts'];
      if (ts is! int) return null;

      final age = DateTime.now().millisecondsSinceEpoch - ts;
      if (age > _cacheTtlSeconds * 1000) return null;

      final body = parsed['body'];
      if (body is Map<String, dynamic>) return body;
    } catch (_) {}

    return null;
  }

  static Future<void> _writeCache(
    String key,
    Map<String, dynamic> data,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final entry = {
        '_ts': DateTime.now().millisecondsSinceEpoch,
        'body': data,
      };

      await prefs.setString(key, jsonEncode(entry));
    } catch (_) {}
  }

  static Future<void> _saveServerStatus(ServerStatus status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_serverStatusKey, jsonEncode(status.toJson()));
    } catch (_) {}
  }
}
