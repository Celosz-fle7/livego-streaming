import 'package:flutter/material.dart';

class TVSafeNavigation {

  static Future<void> open(
    BuildContext context,
    Widget page,
  ) async {

    try {

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => page,
        ),
      );

    } catch (_) {}
  }
}
