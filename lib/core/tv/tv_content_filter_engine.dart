class TVContentFilterEngine {
  static bool enabled = false;

  static final blockedGenres = <String>[];

  static void blockGenre(
    String genre,
  ) {
    blockedGenres.add(genre);
  }
}
