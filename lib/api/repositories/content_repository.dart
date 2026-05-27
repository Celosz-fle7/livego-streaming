import '../cache/api_memory_cache.dart';
import '../models/api_response.dart';
import '../models/content_item.dart';
import '../services/api_client.dart';

class ContentRepository {
  static Future<ApiResponse<List<ContentItem>>> trending() async {
    const key = 'trending';

    if (ApiMemoryCache.has(key)) {
      return ApiResponse.ok(
        ApiMemoryCache.get(key) as List<ContentItem>,
      );
    }

    final res = await ApiClient.get('/trending');

    if (!res.success) {
      return ApiResponse.fail(res.error);
    }

    final raw = res.data;

    final list = raw is List
        ? raw
            .map((e) => ContentItem.fromJson(Map<String, dynamic>.from(e)))
            .toList()
        : <ContentItem>[];

    ApiMemoryCache.set(key, list);

    return ApiResponse.ok(list);
  }
}
