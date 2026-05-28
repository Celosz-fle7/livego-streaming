class TVDownloadQueue {
  static final List<String>
      queue = [];

  static void add(String id) {
    queue.add(id);
  }

  static void remove(String id) {
    queue.remove(id);
  }

  static void clear() {
    queue.clear();
  }
}
