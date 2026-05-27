import 'package:flutter/services.dart';

class TVShortcuts {

  // =========================
  // MEDIA KEYS
  // =========================

  static bool isPlayPause(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.mediaPlayPause ||
        key ==
            LogicalKeyboardKey.select ||
        key ==
            LogicalKeyboardKey.enter;
  }

  static bool isFastForward(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.mediaFastForward ||
        key ==
            LogicalKeyboardKey.arrowRight;
  }

  static bool isRewind(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.mediaRewind ||
        key ==
            LogicalKeyboardKey.arrowLeft;
  }

  static bool isNext(
    LogicalKeyboardKey key,
  ) {
    return key ==
        LogicalKeyboardKey.mediaTrackNext;
  }

  static bool isPrevious(
    LogicalKeyboardKey key,
  ) {
    return key ==
        LogicalKeyboardKey.mediaTrackPrevious;
  }

  static bool isMenu(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.contextMenu ||
        key ==
            LogicalKeyboardKey.settings;
  }

  static bool isBack(
    LogicalKeyboardKey key,
  ) {
    return key ==
            LogicalKeyboardKey.goBack ||
        key ==
            LogicalKeyboardKey.escape;
  }

  // =========================
  // SEEK SPEED
  // =========================

  static const int shortSeek = 10;

  static const int mediumSeek = 30;

  static const int longSeek = 60;
}
