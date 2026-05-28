import 'package:flutter/material.dart';

class TVImageCache {
  static final Set<String> _cachedUrls = {};

  static Future<void> precache(
    BuildContext context,
    String? url,
  ) async {
    if (url == null || url.isEmpty) return;
    if (_cachedUrls.contains(url)) return;

    try {
      await precacheImage(
        NetworkImage(url),
        context,
      );

      _cachedUrls.add(url);
    } catch (_) {}
  }

  static Future<void> precacheMany(
    BuildContext context,
    List items, {
    int limit = 8,
  }) async {
    final urls = items
        .take(limit)
        .map((e) => e is Map ? e['cover']?.toString() : null)
        .where((e) => e != null && e.isNotEmpty)
        .cast<String>()
        .toList();

    for (final url in urls) {
      if (!context.mounted) return;
      await precache(context, url);
    }
  }

  static void clear() {
    _cachedUrls.clear();
  }
}
