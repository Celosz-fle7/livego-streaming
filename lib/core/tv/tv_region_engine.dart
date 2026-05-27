class TVRegionEngine {
  static String region =
      'Indonesia';

  static final supported = [
    'Indonesia',
    'Singapore',
    'Japan',
    'Korea',
    'Global',
  ];

  static void setRegion(
    String value,
  ) {
    region = value;
  }
}
