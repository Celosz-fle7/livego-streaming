import 'package:flutter/material.dart';

class TVScrollRestore {
  static final Map<String, double>
      _offsets = {};

  static void save(
    String key,
    ScrollController controller,
  ) {
    if (!controller.hasClients) return;

    _offsets[key] = controller.offset;
  }

  static void restore(
    String key,
    ScrollController controller,
  ) {
    final offset = _offsets[key];

    if (offset == null) return;

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller.jumpTo(offset);
      }
    });
  }

  static void clear() {
    _offsets.clear();
  }
}
