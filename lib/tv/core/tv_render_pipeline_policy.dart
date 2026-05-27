import 'tv_low_memory_mode.dart';

class TVRenderPipelinePolicy {
  static bool repaintBoundary = true;
  static bool lazyGrid = true;
  static bool cacheExtent = false;
  static bool keepAlive = false;

  static int gridCache = 2;

  static void apply() {
    if (TVLowMemoryMode.enabled) {
      repaintBoundary = true;
      lazyGrid = true;
      cacheExtent = false;
      keepAlive = false;
      gridCache = 1;
      return;
    }

    repaintBoundary = true;
    lazyGrid = true;
    cacheExtent = true;
    keepAlive = true;
    gridCache = 6;
  }
}
