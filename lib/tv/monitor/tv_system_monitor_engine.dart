class TVSystemMonitorEngine {

  static bool monitoring =
      false;

  static int scans = 0;

  static void start() {

    monitoring = true;
  }

  static void stop() {

    monitoring = false;
  }

  static void scan() {

    scans++;
  }
}
