import 'package:flutter/material.dart';

class TVNavigationController {

  static final Map<String, ScrollController>
      _scrollControllers = {};

  static final Map<String, int>
      _lastIndexes = {};

  // =========================
  // SCROLL CONTROLLER
  // =========================

  static ScrollController scroll(
    String id,
  ) {
    if (_scrollControllers.containsKey(id)) {
      return _scrollControllers[id]!;
    }

    final controller =
        ScrollController();

    _scrollControllers[id] =
        controller;

    return controller;
  }

  // =========================
  // SAVE LAST FOCUS
  // =========================

  static void saveIndex({
    required String section,
    required int index,
  }) {
    _lastIndexes[section] = index;
  }

  static int getLastIndex(
    String section,
  ) {
    return _lastIndexes[section] ?? 0;
  }

  // =========================
  // AUTO SCROLL
  // =========================

  static void autoScroll({
    required ScrollController controller,
    required int index,
    double itemWidth = 220,
    double offset = 80,
  }) {
    if (!controller.hasClients) return;

    final target =
        (index * itemWidth) - offset;

    final max =
        controller.position.maxScrollExtent;

    final finalOffset =
        target.clamp(0, max);

    controller.animateTo(
      finalOffset,
      duration: const Duration(
        milliseconds: 220,
      ),
      curve: Curves.easeOut,
    );
  }

  // =========================
  // CLEANUP
  // =========================

  static void disposeAll() {
    for (final c
        in _scrollControllers.values) {
      c.dispose();
    }

    _scrollControllers.clear();
    _lastIndexes.clear();
  }
}
