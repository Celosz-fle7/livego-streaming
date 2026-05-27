import '../core/tv_home_policy.dart';
import '../core/tv_image_policy.dart';
import '../core/tv_player_policy.dart';
import '../core/tv_navigation_policy.dart';

class TVPerformanceLimits {
  static int get maxRails => TVHomePolicy.maxRails;
  static int get maxItemsPerRail => TVHomePolicy.maxItemsPerRail;

  static int get imageWidth => TVImagePolicy.cacheWidth;
  static int get imageHeight => TVImagePolicy.cacheHeight;

  static String get playerQuality => TVPlayerPolicy.defaultQuality;
  static int get playerBitrate => TVPlayerPolicy.maxBitrate;

  static int get focusMs => TVNavigationPolicy.focusAnimationMs;
  static int get repeatMs => TVNavigationPolicy.repeatDelayMs;
}
