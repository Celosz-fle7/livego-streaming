class TVLiveSystemBus {

  static final Map<
      String,
      dynamic
  > events = {};

  static void publish(
    String key,
    dynamic value,
  ) {

    events[key] = value;
  }

  static dynamic read(
    String key,
  ) {

    return events[key];
  }

  static void clear() {

    events.clear();
  }
}
