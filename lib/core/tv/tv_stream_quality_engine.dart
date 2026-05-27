class TVStreamQualityEngine {
  static String current =
      '1080P';

  static int bitrate = 4500;

  static void setQuality(
    String quality,
    int rate,
  ) {
    current = quality;
    bitrate = rate;
  }
}
