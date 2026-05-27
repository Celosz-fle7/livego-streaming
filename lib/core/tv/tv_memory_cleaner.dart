import 'package:flutter/painting.dart';

class TVMemoryCleaner {
  static void clearImageCache() {
    imageCache.clear();
    imageCache.clearLiveImages();
  }
}
