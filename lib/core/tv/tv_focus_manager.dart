import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TVFocusManager {

  static final Map<String, FocusNode> _nodes = {};

  static FocusNode getNode(String id) {
    if (_nodes.containsKey(id)) {
      return _nodes[id]!;
    }

    final node = FocusNode(
      debugLabel: id,
    );

    _nodes[id] = node;

    return node;
  }

  static void request(String id) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final node = _nodes[id];

      if (node != null && node.canRequestFocus) {
        node.requestFocus();
      }
    });
  }

  static void disposeNode(String id) {
    final node = _nodes[id];

    if (node != null) {
      node.dispose();
      _nodes.remove(id);
    }
  }

  static void disposeAll() {
    for (final node in _nodes.values) {
      node.dispose();
    }

    _nodes.clear();
  }

  // =========================
  // TV KEY HELPERS
  // =========================

  static bool isSelect(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.select ||
        key == LogicalKeyboardKey.enter;
  }

  static bool isBack(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.goBack ||
        key == LogicalKeyboardKey.escape;
  }

  static bool isUp(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.arrowUp;
  }

  static bool isDown(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.arrowDown;
  }

  static bool isLeft(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.arrowLeft;
  }

  static bool isRight(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.arrowRight;
  }
}
