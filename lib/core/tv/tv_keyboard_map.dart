import 'package:flutter/services.dart';

class TVKeyboardMap {
  static bool isSelect(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.enter ||
        key ==
            LogicalKeyboardKey
                .select ||
        key ==
            LogicalKeyboardKey
                .mediaPlayPause;
  }

  static bool isBack(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey
                .escape ||
        key ==
            LogicalKeyboardKey
                .goBack;
  }

  static bool isForward(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey
                .arrowRight ||
        key ==
            LogicalKeyboardKey
                .mediaFastForward;
  }

  static bool isRewind(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey
                .arrowLeft ||
        key ==
            LogicalKeyboardKey
                .mediaRewind;
  }
}
