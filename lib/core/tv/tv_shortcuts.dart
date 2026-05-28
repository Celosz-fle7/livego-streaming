import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TVShortcuts {
  static Map<ShortcutActivator, Intent>
      shortcuts = {
    const SingleActivator(
      LogicalKeyboardKey.select,
    ): const ActivateIntent(),

    const SingleActivator(
      LogicalKeyboardKey.enter,
    ): const ActivateIntent(),

    const SingleActivator(
      LogicalKeyboardKey.goBack,
    ): const DismissIntent(),

    const SingleActivator(
      LogicalKeyboardKey.escape,
    ): const DismissIntent(),
  };
}
