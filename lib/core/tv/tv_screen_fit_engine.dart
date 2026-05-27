class TVScreenFitEngine {
  static String mode =
      'FIT';

  static final modes = [
    'FIT',
    'FILL',
    'STRETCH',
    'ZOOM',
  ];

  static void setMode(
    String value,
  ) {
    mode = value;
  }
}
