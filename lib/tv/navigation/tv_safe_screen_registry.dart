class TVSafeScreenRegistry {

  static final Map<String, bool>
      screens = {

    '/home': true,
    '/live': true,
    '/sports': true,
    '/search': true,
    '/system': true,
    '/profile': true,
    '/settings': true,
  };

  static bool exists(
    String route,
  ) {

    return screens[route] ?? false;
  }
}
