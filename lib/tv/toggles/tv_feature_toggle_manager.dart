class TVFeatureToggleManager {

  static final Map<String, bool>
      toggles = {

    'system': true,
    'sports': true,
    'search': true,
    'profile': true,
    'settings': true,
    'live': true,
  };

  static bool enabled(
    String key,
  ) {

    return toggles[key] ?? false;
  }

  static void set(
    String key,
    bool value,
  ) {

    toggles[key] = value;
  }
}
