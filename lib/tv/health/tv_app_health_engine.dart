class TVAppHealthEngine {

  static int fps = 60;

  static int memory = 1200;

  static int cache = 300;

  static bool healthy = true;

  static void update({
    int? newFps,
    int? newMemory,
    int? newCache,
  }) {

    if (newFps != null) {
      fps = newFps;
    }

    if (newMemory != null) {
      memory = newMemory;
    }

    if (newCache != null) {
      cache = newCache;
    }

    healthy =
        fps > 20 &&
        memory < 4000;
  }
}
