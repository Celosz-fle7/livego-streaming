import 'tv_low_memory_mode.dart';

class TVAPKPolicy {
  static bool splitAbi = true;
  static bool shrinkResources = true;
  static bool minify = false;
  static String target = 'LOW_END_TV';

  static void apply() {
    if (TVLowMemoryMode.enabled) {
      splitAbi = true;
      shrinkResources = true;
      minify = false;
      target = 'LOW_END_TV';
      return;
    }

    splitAbi = true;
    shrinkResources = true;
    minify = true;
    target = 'FULL_TV';
  }
}
