import 'package:flutter/material.dart';

class TVHeroPreload {
  static Future<void> preload(
    BuildContext context,
    String? image,
  ) async {
    if (image == null ||
        image.isEmpty) {
      return;
    }

    try {
      await precacheImage(
        NetworkImage(image),
        context,
      );
    } catch (_) {}
  }
}
