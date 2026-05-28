class TVOfflineLibrary {
  static final List<String>
      downloads = [];

  static void add(String id) {
    if (!downloads.contains(id)) {
      downloads.add(id);
    }
  }

  static void remove(String id) {
    downloads.remove(id);
  }

  static bool has(String id) {
    return downloads.contains(id);
  }
}
