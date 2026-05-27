import '../cache/api_memory_cache.dart';
import '../models/api_response.dart';
import '../models/watch_history_item.dart';
import '../services/api_client.dart';

class WatchHistoryRepository {

  static Future<ApiResponse<List<WatchHistoryItem>>>
      continueWatching() async {

    const key = 'continue_watching';

    if (ApiMemoryCache.has(key)) {

      return ApiResponse.ok(
        ApiMemoryCache.get(key)
            as List<WatchHistoryItem>,
      );
    }

    final res = await ApiClient.get(
      '/continue-watching',
    );

    if (!res.success) {
      return ApiResponse.fail(
        res.error,
      );
    }

    final raw = res.data;

    final list = raw is List
        ? raw.map((e) {

            return WatchHistoryItem.fromJson(
              Map<String, dynamic>.from(e),
            );

          }).toList()
        : <WatchHistoryItem>[];

    ApiMemoryCache.set(
      key,
      list,
    );

    return ApiResponse.ok(
      list,
    );
  }

  static Future<ApiResponse<bool>>
      saveProgress({
    required String id,
    required int position,
    required int duration,
  }) async {

    try {

      ApiMemoryCache.set(
        'progress_$id',
        {
          'position': position,
          'duration': duration,
        },
      );

      return ApiResponse.ok(true);

    } catch (e) {

      return ApiResponse.fail(
        '$e',
      );
    }
  }
}
