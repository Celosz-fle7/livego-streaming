import 'package:flutter/material.dart';

class TVRowController {
  static final Map<String, int> _memory = {};

  final String sectionId;

  final ScrollController scrollController =
      ScrollController();

  final Map<int, FocusNode> _nodes = {};

  TVRowController({
    required this.sectionId,
  });

  int get lastIndex =>
      _memory[sectionId] ?? 0;

  void save(int index) {
    _memory[sectionId] = index;
  }

  FocusNode node(
    int index, {
    VoidCallback? onFocused,
  }) {
    if (_nodes[index] != null) {
      return _nodes[index]!;
    }

    final node = FocusNode();

    node.addListener(() {
      if (node.hasFocus) {
        save(index);

        _autoScroll(index);

        if (onFocused != null) {
          onFocused();
        }
      }
    });

    _nodes[index] = node;

    return node;
  }

  void requestLastFocus() {
    final idx = lastIndex;

    if (_nodes[idx] != null) {
      _nodes[idx]!.requestFocus();
    }
  }

  void _autoScroll(int index) {
    if (!scrollController.hasClients) return;

    final target =
        (index * 190).toDouble();

    scrollController.animateTo(
      target,
      duration: const Duration(
        milliseconds: 260,
      ),
      curve: Curves.easeOut,
    );
  }

  void dispose() {
    for (final n in _nodes.values) {
      n.dispose();
    }

    scrollController.dispose();
  }
}
