class TVPlayerAnalyticsEngine {
  static int plays = 0;

  static int pauses = 0;

  static int seeks = 0;

  static void play() {
    plays++;
  }

  static void pause() {
    pauses++;
  }

  static void seek() {
    seeks++;
  }
}
