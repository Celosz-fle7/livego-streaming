import 'tv_low_memory_mode.dart';

class TVDeviceProfileMode {
  static String profile = 'UNKNOWN';
  static int ramGb = 2;

  static void detect({
    required int ram,
  }) {
    ramGb = ram;

    if (ram <= 2) {
      profile = 'LOW_END_TV';
      TVLowMemoryMode.enable();
      return;
    }

    if (ram <= 4) {
      profile = 'MID_TV';
      TVLowMemoryMode.balanced();
      return;
    }

    profile = 'HIGH_TV';
    TVLowMemoryMode.disable();
  }
}
