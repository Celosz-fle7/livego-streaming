class TVTemperatureEngine {
  static double temp = 42.0;

  static void update(double value) {
    temp = value;
  }

  static bool get hot => temp >= 70;
}
