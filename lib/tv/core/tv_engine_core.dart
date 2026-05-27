class TVEngineCore {

  static bool initialized = false;

  static int loadedFeatures = 0;

  static void initialize(
    int total,
  ) {
    initialized = true;
    loadedFeatures = total;
  }

  static void reset() {
    initialized = false;
    loadedFeatures = 0;
  }
}
