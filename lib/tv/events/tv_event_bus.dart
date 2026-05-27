class TVEventBus {

  static final Map<
      String,
      List<Function(dynamic)>
  > _listeners = {};

  static void on(
    String event,
    Function(dynamic) callback,
  ) {

    _listeners.putIfAbsent(
      event,
      () => [],
    );

    _listeners[event]!
        .add(callback);
  }

  static void emit(
    String event,
    dynamic payload,
  ) {

    if (!_listeners
        .containsKey(event)) {
      return;
    }

    for (final listener
        in _listeners[event]!) {

      listener(payload);
    }
  }

  static void clear() {

    _listeners.clear();
  }
}
