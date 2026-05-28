import 'package:flutter/material.dart';

class TVRouteTransition {
  static Route slide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(
        milliseconds: 260,
      ),
      reverseTransitionDuration:
          const Duration(
        milliseconds: 220,
      ),
      pageBuilder:
          (_, animation, __) {
        return FadeTransition(
          opacity: animation,
          child: page,
        );
      },
    );
  }
}
