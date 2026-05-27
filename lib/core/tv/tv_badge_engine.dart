class TVBadgeEngine {
  static final Map<String, String>
      badges = {};

  static void set(
    String id,
    String badge,
  ) {
    badges[id] = badge;
  }

  static String get(String id) {
    return badges[id] ?? '';
  }
}
