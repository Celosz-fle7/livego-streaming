class TVCrashRecorder {

  static final List<String>
      crashes = [];

  static void record(
    String error,
  ) {

    crashes.insert(0, error);

    if (crashes.length > 25) {
      crashes.removeLast();
    }
  }
}
