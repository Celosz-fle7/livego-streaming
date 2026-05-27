import 'package:flutter/material.dart';

class TVFocusManager {
  static final Map<String, FocusNode> _saved = {};

  static void save(
    String key,
    FocusNode node,
  ) {
    _saved[key] = node;
  }

  static void restore(String key) {
    final node = _saved[key];

    if (node != null && node.canRequestFocus) {
      Future.microtask(() {
        node.requestFocus();
      });
    }
  }

  static void clear() {
    _saved.clear();
  }
}
