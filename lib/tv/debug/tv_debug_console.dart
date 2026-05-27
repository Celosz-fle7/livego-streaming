class TVDebugConsole {

  static final List<String>
      logs = [];

  static bool enabled = true;

  static void log(
    String value,
  ) {

    if (!enabled) return;

    logs.insert(
      0,
      value,
    );

    if (logs.length > 50) {
      logs.removeLast();
    }
  }

  static void clear() {
    logs.clear();
  }
}
