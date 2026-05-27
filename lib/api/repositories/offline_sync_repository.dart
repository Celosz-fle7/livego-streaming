import '../cache/local_store.dart';

class OfflineSyncRepository {

  static const _queueKey =
      'offline_sync_queue';

  static Future<List<Map<String, dynamic>>>
      queue() async {

    final raw =
        await LocalStore.get(
      _queueKey,
    );

    if (raw is! List) {
      return [];
    }

    return raw.map((e) {

      return Map<String, dynamic>.from(e);

    }).toList();
  }

  static Future<void> addTask(
    Map<String, dynamic> task,
  ) async {

    final q = await queue();

    q.add(task);

    await LocalStore.set(
      _queueKey,
      q,
    );
  }

  static Future<void> clear()
      async {

    await LocalStore.remove(
      _queueKey,
    );
  }
}
