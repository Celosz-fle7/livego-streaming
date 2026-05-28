import '../models/api_response.dart';
import '../services/api_retry_client.dart';
import 'offline_sync_repository.dart';

class OfflineSyncExecutor {
  static bool syncing = false;
  static int synced = 0;
  static int failed = 0;

  static Future<ApiResponse<bool>> sync() async {
    if (syncing) {
      return ApiResponse.ok(true);
    }

    syncing = true;

    final tasks = await OfflineSyncRepository.queue();

    for (final task in tasks) {
      final path = '${task['path'] ?? ''}';
      final body = Map<String, dynamic>.from(task['body'] ?? {});

      if (path.isEmpty) {
        failed++;
        continue;
      }

      final res = await ApiRetryClient.post(path, body);

      if (res.success) {
        synced++;
      } else {
        failed++;
      }
    }

    if (failed == 0) {
      await OfflineSyncRepository.clear();
    }

    syncing = false;

    return ApiResponse.ok(failed == 0);
  }
}
