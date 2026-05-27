class TVPanelMemoryTracker {

  static int active = 0;

  static int disposed = 0;

  static void mounted() {

    active++;
  }

  static void unmounted() {

    disposed++;
  }
}
