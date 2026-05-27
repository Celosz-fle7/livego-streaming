class TVRouteLogger {

  static final List<String>
      logs = [];

  static void add(
    String route,
  ) {

    logs.insert(0, route);

    if (logs.length > 300) {
      logs.removeLast();
    }
  }
}
