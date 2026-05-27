class TVSmartAdsEngine {
  static bool enabled = false;

  static int blocked = 0;

  static void blockAd() {
    blocked++;
  }
}
