class TVFavoriteEngine {
  static final List<String>
      favorites = [];

  static void add(String id) {
    if (!favorites.contains(id)) {
      favorites.add(id);
    }
  }

  static void remove(String id) {
    favorites.remove(id);
  }

  static bool has(String id) {
    return favorites.contains(id);
  }
}
