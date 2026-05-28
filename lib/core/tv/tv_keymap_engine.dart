class TVKeymapEngine {
  static final Map<String, String>
      bindings = {
    'ENTER': 'PLAY',
    'LEFT': 'SEEK_BACK',
    'RIGHT': 'SEEK_FORWARD',
  };

  static void setBinding(
    String key,
    String value,
  ) {
    bindings[key] = value;
  }
}
