import 'package:flutter/services.dart';

class TVPlayerShortcuts {
  static bool isPlayPause(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.select ||
        key ==
            LogicalKeyboardKey.enter;
  }

  static bool isSeekLeft(
    LogicalKeyboardKey key,
  ) {
    return key ==
        LogicalKeyboardKey.arrowLeft;
  }

  static bool isSeekRight(
    LogicalKeyboardKey key,
  ) {
    return key ==
        LogicalKeyboardKey.arrowRight;
  }

  static bool isBack(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.escape ||
        key ==
            LogicalKeyboardKey.goBack;
  }
}
