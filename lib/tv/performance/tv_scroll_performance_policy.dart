class TVScrollPerformancePolicy {

  static bool deferredLoading =
      true;

  static bool cacheImages =
      false;

  static int preloadItems =
      2;

  static void lowEnd() {

    deferredLoading = true;

    cacheImages = false;

    preloadItems = 1;
  }

  static void highEnd() {

    deferredLoading = false;

    cacheImages = true;

    preloadItems = 6;
  }
}
