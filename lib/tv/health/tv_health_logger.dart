class TVHealthLogger {

  static final List<String>
      logs = [];

  static void add(
    String log,
  ) {

    logs.insert(0, log);

    if (logs.length > 25) {
      logs.removeLast();
    }
  }
}
