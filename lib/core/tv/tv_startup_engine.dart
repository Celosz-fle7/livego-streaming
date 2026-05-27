class TVStartupEngine {
  static bool initialized = false;

  static Future<void> init() async {
    initialized = true;
  }
}
