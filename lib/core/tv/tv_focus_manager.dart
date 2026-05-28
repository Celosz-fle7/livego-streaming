import 'package:flutter/material.dart';

class TVFocusManager {
  static final Map<String, FocusNode> _nodes = {};

  static FocusNode getNode(String id) {
    return _nodes.putIfAbsent(id, () => FocusNode(debugLabel: id));
  }

  static FocusNode get(String id) => getNode(id);

  static void request(String id) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final node = _nodes[id];
      if (node != null && node.canRequestFocus) {
        node.requestFocus();
      }
    });
  }

  static void save(String key, FocusNode node) {
    _nodes[key] = node;
  }

  static void restore(String key) {
    request(key);
  }

  static void disposeNode(String id) {
    _nodes[id]?.dispose();
    _nodes.remove(id);
  }

  static void clear() {
    for (final node in _nodes.values) {
      node.dispose();
    }
    _nodes.clear();
  }
}
