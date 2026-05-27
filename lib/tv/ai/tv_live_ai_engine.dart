class TVLiveAIEngine {

  static bool active =
      true;

  static int decisions =
      0;

  static int scans =
      0;

  static void analyze() {

    scans++;
  }

  static void decide() {

    decisions++;
  }
}
