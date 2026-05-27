class TVNovaEngine {
  static bool exploding = false;

  static int bursts = 0;

  static void burst() {
    exploding = true;
    bursts++;
  }
}
