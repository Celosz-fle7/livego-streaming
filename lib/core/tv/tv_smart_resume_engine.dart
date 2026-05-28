class TVSmartResumeEngine {
  static bool enabled = true;

  static int resumed = 0;

  static void resume() {
    resumed++;
  }
}
