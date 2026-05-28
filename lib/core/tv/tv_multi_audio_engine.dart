class TVMultiAudioEngine {
  static final List<String>
      tracks = [
    'Japanese',
    'English',
    'Indonesia',
  ];

  static String current =
      'Japanese';

  static void setTrack(
    String value,
  ) {
    current = value;
  }
}
