class TVSystemGuard {

  static bool locked = false;

  static bool safeMode = false;

  static void enableSafeMode() {

    safeMode = true;
  }

  static void disableSafeMode() {

    safeMode = false;
  }

  static bool canExecute() {

    return !locked;
  }
}
