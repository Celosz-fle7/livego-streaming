class TVLiveEventStream {

  static final List<String>
      events = [];

  static void emit(
    String value,
  ) {

    events.insert(0, value);

    if (events.length > 100) {
      events.removeLast();
    }
  }

  static List<String> latest() {

    return events;
  }
}
