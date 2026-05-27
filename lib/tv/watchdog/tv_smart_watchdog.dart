class TVSmartWatchdog {

  static bool watching =
      false;

  static int alerts = 0;

  static void start() {

    watching = true;
  }

  static void stop() {

    watching = false;
  }

  static void alert() {

    alerts++;
  }
}
