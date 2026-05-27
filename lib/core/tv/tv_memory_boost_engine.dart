class TVMemoryBoostEngine {
  static bool active = false;

  static int clearedMb = 0;

  static void boost(int mb) {
    active = true;
    clearedMb += mb;
  }

  static void reset() {
    active = false;
    clearedMb = 0;
  }
}
