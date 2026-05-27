class TVSafeNavStack {

  static final List<String>
      routes = [];

  static void push(
    String route,
  ) {

    routes.add(route);
  }

  static void pop() {

    if (routes.isNotEmpty) {
      routes.removeLast();
    }
  }

  static String current() {

    if (routes.isEmpty) {
      return '/';
    }

    return routes.last;
  }

  static void reset() {

    routes.clear();
  }
}
