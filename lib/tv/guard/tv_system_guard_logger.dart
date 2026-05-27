class TVSystemGuardLogger {

  static final List<String>
      logs = [];

  static void add(
    String value,
  ) {

    logs.insert(0, value);

    if (logs.length > 30) {
      logs.removeLast();
    }
  }
}
