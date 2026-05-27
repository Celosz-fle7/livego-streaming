class TVChannelEngine {
  static final List<String>
      channels = [
    'Drama',
    'Anime',
    'Movies',
    'Live TV',
  ];

  static String current =
      'Drama';

  static void setChannel(
    String value,
  ) {
    current = value;
  }
}
