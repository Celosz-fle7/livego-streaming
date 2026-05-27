import 'tv_low_memory_mode.dart';

class TVNavigationPolicy {
  static int focusAnimationMs = 80;
  static int repeatDelayMs = 120;
  static bool smoothScroll = false;
  static bool focusGlow = false;

  static void apply() {
    if (TVLowMemoryMode.enabled) {
      focusAnimationMs = 40;
      repeatDelayMs = 160;
      smoothScroll = false;
      focusGlow = false;
      return;
    }

    focusAnimationMs = 120;
    repeatDelayMs = 90;
    smoothScroll = true;
    focusGlow = true;
  }
}
