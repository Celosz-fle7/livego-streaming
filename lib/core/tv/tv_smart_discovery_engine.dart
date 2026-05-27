class TVSmartDiscoveryEngine {
  static final List<String>
      discovered = [];

  static void add(String item) {
    discovered.add(item);
  }

  static void clear() {
    discovered.clear();
  }
}
