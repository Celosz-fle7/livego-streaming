class TVSmartMemoryEngine {
  static int used = 1200;

  static int free = 2800;

  static void allocate(
    int value,
  ) {
    used += value;
    free -= value;
  }
}
