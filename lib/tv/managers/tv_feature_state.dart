class TVFeatureState {

  static final Map<String, bool>
      states = {};

  static bool enabled(
    String id,
  ) {

    return states[id] ?? true;
  }

  static void set(
    String id,
    bool value,
  ) {

    states[id] = value;
  }
}
