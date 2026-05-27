class TVUltraCacheEngine {
  static bool enabled = true;

  static int cachedItems = 0;

  static void cache() {
    cachedItems++;
  }

  static void reset() {
    cachedItems = 0;
  }
}
