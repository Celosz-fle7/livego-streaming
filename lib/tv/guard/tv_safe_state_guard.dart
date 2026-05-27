class TVSafeStateGuard {

  static bool mounted = true;

  static bool valid() {

    return mounted;
  }

  static void dispose() {

    mounted = false;
  }

  static void restore() {

    mounted = true;
  }
}
