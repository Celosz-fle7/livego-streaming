class TVLiveMemoryWatcher {

  static int usage = 1200;

  static bool warning = false;

  static void update(
    int value,
  ) {

    usage = value;

    warning = value > 3500;
  }
}
