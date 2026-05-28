import 'package:flutter/foundation.dart';

class TVLogger {
  static void log(String text) {
    debugPrint(
      '[DRACIN-TV] $text',
    );
  }
}
