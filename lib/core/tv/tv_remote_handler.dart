import 'package:flutter/services.dart';

import 'tv_remote_throttle.dart';
import 'tv_navigation_engine.dart';

class TVRemoteHandler {
  static bool handle(
    LogicalKeyboardKey key, {
    Function()? onLeft,
    Function()? onRight,
    Function()? onUp,
    Function()? onDown,
    Function()? onSelect,
    Function()? onBack,
  }) {
    if (!TVRemoteThrottle.allow()) {
      return true;
    }

    if (TVNavigationEngine.isLeft(key)) {
      onLeft?.call();
      return true;
    }

    if (TVNavigationEngine.isRight(key)) {
      onRight?.call();
      return true;
    }

    if (TVNavigationEngine.isUp(key)) {
      onUp?.call();
      return true;
    }

    if (TVNavigationEngine.isDown(key)) {
      onDown?.call();
      return true;
    }

    if (TVNavigationEngine.isSelect(key)) {
      onSelect?.call();
      return true;
    }

    if (TVNavigationEngine.isBack(key)) {
      onBack?.call();
      return true;
    }

    return false;
  }
}
