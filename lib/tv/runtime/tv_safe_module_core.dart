class TVSafeModuleCore {

  static final Map<String, bool>
      modules = {};

  static void enable(
    String key,
  ) {

    modules[key] = true;
  }

  static void disable(
    String key,
  ) {

    modules[key] = false;
  }

  static bool active(
    String key,
  ) {

    return modules[key] ?? false;
  }
}
