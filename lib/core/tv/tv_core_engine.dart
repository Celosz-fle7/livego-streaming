class TVCoreEngine {
  static bool initialized = false;

  static Future<void> boot() async {
    initialized = true;
  }
}
