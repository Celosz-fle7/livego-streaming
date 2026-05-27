class TVLiveCommandLogger {

  static final List<String>
      logs = [];

  static void add(
    String command,
  ) {

    logs.insert(0, command);

    if (logs.length > 300) {
      logs.removeLast();
    }
  }
}
