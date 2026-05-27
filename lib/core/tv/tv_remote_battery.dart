class TVRemoteBattery {
  static int battery = 100;

  static void update(int value) {
    battery = value.clamp(0, 100);
  }

  static bool get low => battery <= 20;
}
