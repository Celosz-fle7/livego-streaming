class TVSpeedEngine {
  static final speeds = [
    0.5,
    1.0,
    1.25,
    1.5,
    2.0,
  ];

  static int current = 1;

  static double get value =>
      speeds[current];

  static void next() {
    current++;

    if (current >= speeds.length) {
      current = 0;
    }
  }
}
