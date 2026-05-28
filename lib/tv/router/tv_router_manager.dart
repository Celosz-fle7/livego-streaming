import 'package:flutter/material.dart';

import '../screens/home_screen_v2.dart';
import '../screens/system_screen.dart';

class TVRouterManager {

  static Widget route(
    String path,
  ) {

    switch (path) {

      case '/system':
        return const TVSystemScreen();

      case '/home':
      default:
        return const TVHomeScreenV2();
    }
  }
}
