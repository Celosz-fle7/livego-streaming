class TVSystemEventLogger {

  static final List<String>
      events = [];

  static void log(
    String event,
  ) {

    events.insert(0, event);

    if (events.length > 300) {
      events.removeLast();
    }
  }
}
