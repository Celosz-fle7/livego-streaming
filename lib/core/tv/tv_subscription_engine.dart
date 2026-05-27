class TVSubscriptionEngine {
  static bool active = false;

  static String plan = 'FREE';

  static void activate(
    String name,
  ) {
    active = true;
    plan = name;
  }

  static void deactivate() {
    active = false;
    plan = 'FREE';
  }
}
