class TVSmartSortEngine {
  static String mode =
      'TRENDING';

  static final modes = [
    'TRENDING',
    'POPULAR',
    'LATEST',
    'RATING',
  ];

  static void setMode(
    String value,
  ) {
    mode = value;
  }
}
