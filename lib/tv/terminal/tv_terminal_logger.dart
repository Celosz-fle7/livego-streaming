class TVTerminalLogger {

  static final List<String>
      logs = [];

  static void log(
    String value,
  ) {

    logs.insert(0, value);

    if (logs.length > 40) {
      logs.removeLast();
    }
  }
}
