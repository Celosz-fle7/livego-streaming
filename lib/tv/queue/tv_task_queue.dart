import 'tv_task.dart';

class TVTaskQueue {

  static final List<TVTask>
      _queue = [];

  static bool running = false;

  static void add(
    TVTask task,
  ) {

    _queue.add(task);
  }

  static Future<void>
      process() async {

    if (running) return;

    running = true;

    while (_queue.isNotEmpty) {

      final task =
          _queue.removeAt(0);

      try {

        await task.action();

      } catch (_) {}
    }

    running = false;
  }
}
