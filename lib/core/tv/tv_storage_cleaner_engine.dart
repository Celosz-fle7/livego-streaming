class TVStorageCleanerEngine {
  static int cleanedMb = 0;

  static void clean(int value) {
    cleanedMb += value;
  }

  static void reset() {
    cleanedMb = 0;
  }
}
