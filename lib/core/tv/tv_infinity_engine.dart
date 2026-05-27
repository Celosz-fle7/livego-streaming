class TVInfinityEngine {
  static bool active = true;

  static int power = 1000;

  static void upgrade(
    int value,
  ) {
    power += value;
  }
}
