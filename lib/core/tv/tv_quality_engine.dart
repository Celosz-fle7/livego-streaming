class TVQualityEngine {
  static final List<String>
      qualities = [
    '360P',
    '480P',
    '720P',
    '1080P',
    '4K',
  ];

  static String current =
      '1080P';

  static void setQuality(
    String value,
  ) {
    current = value;
  }
}
