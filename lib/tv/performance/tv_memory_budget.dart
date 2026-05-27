class TVMemoryBudget {
  static int maxImageCacheMb = 64;
  static int maxRuntimeCacheMb = 32;
  static int maxActivePanels = 6;

  static void lowEnd() {
    maxImageCacheMb = 32;
    maxRuntimeCacheMb = 16;
    maxActivePanels = 6;
  }

  static void highEnd() {
    maxImageCacheMb = 128;
    maxRuntimeCacheMb = 64;
    maxActivePanels = 20;
  }
}
