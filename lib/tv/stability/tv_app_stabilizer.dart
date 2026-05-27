class TVAppStabilizer {

  static bool stable = true;

  static int optimizations = 0;

  static void optimize() {

    optimizations++;
  }

  static void unstable() {

    stable = false;
  }

  static void stabilize() {

    stable = true;
  }
}
