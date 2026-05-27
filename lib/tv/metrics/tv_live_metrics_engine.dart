class TVLiveMetricsEngine {

  static int fps = 60;

  static int memory = 1024;

  static int widgets = 0;

  static int renders = 0;

  static void update({
    int? newFps,
    int? newMemory,
    int? newWidgets,
    int? newRenders,
  }) {

    if (newFps != null) {
      fps = newFps;
    }

    if (newMemory != null) {
      memory = newMemory;
    }

    if (newWidgets != null) {
      widgets = newWidgets;
    }

    if (newRenders != null) {
      renders = newRenders;
    }
  }
}
