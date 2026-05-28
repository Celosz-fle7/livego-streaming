import 'tv_low_memory_mode.dart';
import 'tv_apk_policy.dart';
import 'tv_player_policy.dart';
import 'tv_home_policy.dart';
import 'tv_image_policy.dart';

class TVReleaseProfilePolicy {
  static String profile = 'LOW';

  static void applyLow() {
    profile = 'LOW';
    TVLowMemoryMode.enable();
    TVAPKPolicy.apply();
    TVPlayerPolicy.apply();
    TVHomePolicy.apply();
    TVImagePolicy.apply();
  }

  static void applyBalanced() {
    profile = 'BALANCED';
    TVLowMemoryMode.balanced();
    TVAPKPolicy.apply();
    TVPlayerPolicy.apply();
    TVHomePolicy.apply();
    TVImagePolicy.apply();
  }

  static void applyFull() {
    profile = 'FULL';
    TVLowMemoryMode.disable();
    TVAPKPolicy.apply();
    TVPlayerPolicy.apply();
    TVHomePolicy.apply();
    TVImagePolicy.apply();
  }
}
