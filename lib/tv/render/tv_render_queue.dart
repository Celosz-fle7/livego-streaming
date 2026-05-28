class TVRenderQueue {

  static final List<String>
      queue = [];

  static void add(
    String widget,
  ) {

    queue.add(widget);
  }

  static void clear() {

    queue.clear();
  }

  static int total() {

    return queue.length;
  }
}
