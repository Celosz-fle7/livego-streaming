import 'package:flutter/material.dart';

class TVSmartPreload {
  static Future<void> preload(
    BuildContext context,
    List items,
  ) async {
    for (final item in items.take(6)) {
      final image =
          item['cover']?.toString();

      if (image == null ||
          image.isEmpty) {
        continue;
      }

      try {
        await precacheImage(
          NetworkImage(image),
          context,
        );
      } catch (_) {}
    }
  }
}
