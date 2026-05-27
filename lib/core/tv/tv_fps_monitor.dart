import 'package:flutter/foundation.dart';

class TVFPSMonitor {
  static void logFrame(String text) {
    debugPrint(
      '[TV-FPS] $text',
    );
  }
}
