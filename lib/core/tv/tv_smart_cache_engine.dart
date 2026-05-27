class TVSmartCacheEngine {
  static bool enabled = true;

  static int cacheHits = 0;

  static void hit() {
    cacheHits++;
  }
}
