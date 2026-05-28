import 'package:flutter/material.dart';

class TVPanelAnimator {
  static Widget fade({
    required bool visible,
    required Widget child,
  }) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration:
          const Duration(milliseconds: 180),
      child: child,
    );
  }

  static Widget slideUp({
    required bool visible,
    required Widget child,
  }) {
    return AnimatedSlide(
      offset:
          visible
              ? Offset.zero
              : const Offset(0, 1),
      duration:
          const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      child: child,
    );
  }
}
