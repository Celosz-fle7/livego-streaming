import 'tv_low_memory_mode.dart';

class TVDeviceSafetyMode {
  static bool thermalSafe = false;
  static bool batterySafe = false;

  static int temperature = 42;
  static int battery = 100;

  static void update({
    int? temp,
    int? level,
  }) {
    if (temp != null) {
      temperature = temp;
    }

    if (level != null) {
      battery = level;
    }

    thermalSafe = temperature >= 70;
    batterySafe = battery <= 20;

    if (thermalSafe || batterySafe) {
      TVLowMemoryMode.enable();
    }
  }
}
