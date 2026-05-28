class TVRuntimeState {

  static bool booted = false;

  static bool ready = false;

  static int activeWidgets = 0;

  static void reset() {

    booted = false;
    ready = false;
    activeWidgets = 0;
  }
}
