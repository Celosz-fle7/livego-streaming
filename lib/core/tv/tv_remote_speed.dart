class TVRemoteSpeed {
  static int repeatDelay = 90;

  static void fast() {
    repeatDelay = 50;
  }

  static void normal() {
    repeatDelay = 90;
  }

  static void slow() {
    repeatDelay = 140;
  }
}
