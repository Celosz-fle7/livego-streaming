import 'package:flutter/services.dart';

class TVNavigationEngine {
  static bool isSelect(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.select ||
        key == LogicalKeyboardKey.enter;
  }

  static bool isBack(LogicalKeyboardKey key) {
    return key == LogicalKeyboardKey.escape ||
        key == LogicalKeyboardKey.goBack;
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
