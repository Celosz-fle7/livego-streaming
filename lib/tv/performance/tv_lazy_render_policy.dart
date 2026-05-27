class TVLazyRenderPolicy {
  static bool enabled = true;
  static int firstBatch = 8;
  static int nextBatch = 6;

  static void lowEnd() {
    enabled = true;
    firstBatch = 6;
    nextBatch = 4;
  }

  static void highEnd() {
    enabled = true;
    firstBatch = 14;
    nextBatch = 10;
  }
}
