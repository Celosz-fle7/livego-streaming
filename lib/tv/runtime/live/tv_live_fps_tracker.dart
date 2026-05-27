class TVLiveFPSTracker {

  static int fps = 60;

  static bool smooth = true;

  static void update(
    int value,
  ) {

    fps = value;

    smooth = value >= 50;
  }
}
