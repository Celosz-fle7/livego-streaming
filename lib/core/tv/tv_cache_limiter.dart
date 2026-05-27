import 'package:flutter/painting.dart';

class TVCacheLimiter {
  static void apply() {
    imageCache.maximumSize = 120;

    imageCache.maximumSizeBytes =
        120 << 20;
  }
}
