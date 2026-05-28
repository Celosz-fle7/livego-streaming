class TVJankGuard {
  static int droppedFrames = 0;
  static bool jankDetected = false;

  static void reportDrop() {
    droppedFrames++;
    jankDetected = droppedFrames >= 5;
  }

  static void reset() {
    droppedFrames = 0;
    jankDetected = false;
  }
}
