import 'package:flutter/material.dart';

class TVFocusRestore {
  static final Map<String, FocusNode>
      _nodes = {};

  static void save(
    String key,
    FocusNode node,
  ) {
    _nodes[key] = node;
  }

  static void restore(String key) {
    final node = _nodes[key];

    if (node == null) return;

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      if (node.canRequestFocus) {
        node.requestFocus();
      }
    });
  }

  static void clear() {
    _nodes.clear();
  }
}
