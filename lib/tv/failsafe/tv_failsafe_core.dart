class TVFailsafeCore {

  static bool emergency =
      false;

  static void trigger() {

    emergency = true;
  }

  static void reset() {

    emergency = false;
  }
}
