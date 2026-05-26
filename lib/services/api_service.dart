// lib/services/api_service.dart
// FINAL - ApiService with caching, ServerStatus, and static helpers

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_constants.dart';

class ServerStatus {
  final bool isOnline;
  final int latencyMs;
  final String statusText;
  final String colorLabel; // 'green' | 'yellow' | 'red'
  final DateTime checkedAt;

  const ServerStatus({
    required this.isOnline,
    required this.latencyMs,
    required this.statusText,
    required this.colorLabel,
    required this.checkedAt,
  });

  factory ServerStatus.fromCheck({required bool isOnline, required int latencyMs}) {
    String text;
    String color;
    if (!isOnline) {
      text = 'Server offline';
      color = 'red';
    } else if (latencyMs < 500) {
      text = 'Online · ${latencyMs}ms';
      color = 'green';
    } else if (latencyMs < 1500) {
      text = 'Lambat · ${latencyMs}ms';
      color = 'yellow';
    } else {
      text = 'Sangat lambat · ${latencyMs}ms';
      color = 'red';
    }
    return ServerStatus(
      isOnline: isOnline,
      latencyMs: latencyMs,
      statusText: text,
      colorLabel: color,
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

  factory ServerStatus.fromJson(Map<String, dynamic> json) => ServerStatus(
    isOnline: json['isOnline'] ?? false,
    latencyMs: json['latencyMs'] ?? 0,
    statusText: json['statusText'] ?? '',
    colorLabel: json['colorLabel'] ?? 'red',
    checkedAt: DateTime.fromMillisecondsSinceEpoch(json['checkedAt'] ?? 0),
  );
}

class ApiService {
  static const String _cachePrefix = 'api_cache_';
  static const String _serverStatusKey = 'server_status_last';
  static const int _cacheTtlSeconds = 300; // 5 menit

  // ─── HTTP GET with in-memory + SharedPreferences cache ───────────────────
  static Future<Map<String, dynamic>?> get(
    String path, {
    bool forceRefresh = false,
  }) async {
    final url = '${ApiConstants.baseUrl}$path';
    final cacheKey = '$_cachePrefix${path.hashCode}';

    if (!forceRefresh) {
      final cached = await _readCache(cacheKey);
      if (cached != null) return cached;
    }

    try {
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      if (ApiConstants.hasKey) {
        headers['X-API-Key'] = ApiConstants.secret;
      }

      final sw = Stopwatch()..start();
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 15));
      sw.stop();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          await _writeCache(cacheKey, decoded);
          return decoded;
        }
        // Kalau response array, bungkus supaya konsisten
        if (decoded is List) {
          final wrapped = {'data': decoded, 'success': true};
          await _writeCache(cacheKey, wrapped);
          return wrapped;
        }
      }
    } catch (e) {
      debugPrint('❌ ApiService.get error: $path → $e');
    }
    return null;
  }

  // ─── Server status check ─────────────────────────────────────────────────
  static Future<ServerStatus> checkServerStatus() async {
    final url = '${ApiConstants.baseUrl}/api/ping';
    try {
      final sw = Stopwatch()..start();
      final res = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));
      sw.stop();
      final status = ServerStatus.fromCheck(
        isOnline: res.statusCode >= 200 && res.statusCode < 300,
        latencyMs: sw.elapsedMilliseconds,
      );
      await _saveServerStatus(status);
      return status;
    } catch (_) {
      final status = ServerStatus.fromCheck(isOnline: false, latencyMs: 0);
      await _saveServerStatus(status);
      return status;
    }
  }

  // ─── Get last saved status (dari SharedPreferences) ──────────────────────
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

  // ─── Clear all cache ──────────────────────────────────────────────────────
  static Future<void> clearAllCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys().where((k) => k.startsWith(_cachePrefix)).toList();
      for (final key in keys) {
        await prefs.remove(key);
      }
      debugPrint('🗑️ Cache cleared: ${keys.length} entries');
    } catch (e) {
      debugPrint('❌ clearAllCache error: $e');
    }
  }

  // ─── Private helpers ──────────────────────────────────────────────────────
  static Future<Map<String, dynamic>?> _readCache(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(key);
      if (raw == null) return null;
      final parsed = jsonDecode(raw) as Map<String, dynamic>;
      final ts = parsed['_ts'] as int? ?? 0;
      final age = DateTime.now().millisecondsSinceEpoch - ts;
      if (age > _cacheTtlSeconds * 1000) return null; // expired
      return parsed['body'] as Map<String, dynamic>?;
    } catch (_) {
      return null;
    }
  }

  static Future<void> _writeCache(String key, Map<String, dynamic> data) async {
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
