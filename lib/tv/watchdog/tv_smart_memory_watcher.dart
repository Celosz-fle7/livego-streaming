class TVSmartMemoryWatcher {

  static int memory =
      1024;

  static bool danger =
      false;

  static void update(
    int value,
  ) {

    memory = value;

    danger = value > 3500;
  }
}
