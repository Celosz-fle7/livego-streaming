class TVPerformanceHUDEngine {

  static bool visible =
      true;

  static int fps = 60;

  static int memory = 1200;

  static int cpu = 15;

  static void update({
    int? newFps,
    int? newMemory,
    int? newCpu,
  }) {

    if (newFps != null) {
      fps = newFps;
    }

    if (newMemory != null) {
      memory = newMemory;
    }

    if (newCpu != null) {
      cpu = newCpu;
    }
  }
}
