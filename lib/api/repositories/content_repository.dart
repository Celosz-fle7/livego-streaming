import '../cache/api_memory_cache.dart';
import '../models/api_response.dart';
import '../models/content_detail.dart';
import '../models/content_item.dart';
import '../models/video_source.dart';
import '../services/api_client.dart';

class ContentRepository {
  static Future<ApiResponse<List<ContentItem>>> trending() async {
    return _list(
      key: 'trending',
      path: '/trending',
    );
  }

  static Future<ApiResponse<List<ContentItem>>> search(String query) async {
    return _list(
      key: 'search_$query',
      path: '/search?q=${Uri.encodeComponent(query)}',
    );
  }

  static Future<ApiResponse<ContentDetail>> detail(String id) async {
    final key = 'detail_$id';

    if (ApiMemoryCache.has(key)) {
      return ApiResponse.ok(
        ApiMemoryCache.get(key) as ContentDetail,
      );
    }

    final res = await ApiClient.get('/detail/$id');

    if (!res.success) {
      return ApiResponse.fail(res.error);
    }

    final detail = ContentDetail.fromJson(
      Map<String, dynamic>.from(res.data),
    );

    ApiMemoryCache.set(key, detail);

    return ApiResponse.ok(detail);
  }

  static Future<ApiResponse<List<VideoSource>>> videos(String id) async {
    final key = 'videos_$id';

    if (ApiMemoryCache.has(key)) {
      return ApiResponse.ok(
        ApiMemoryCache.get(key) as List<VideoSource>,
      );
    }

    final res = await ApiClient.get('/video/$id');

    if (!res.success) {
      return ApiResponse.fail(res.error);
    }

    final raw = res.data;

    final list = raw is List
        ? raw
            .map((e) => VideoSource.fromJson(Map<String, dynamic>.from(e)))
            .toList()
        : <VideoSource>[];

    ApiMemoryCache.set(key, list);

    return ApiResponse.ok(list);
  }

  static Future<ApiResponse<List<ContentItem>>> _list({
    required String key,
    required String path,
  }) async {
    if (ApiMemoryCache.has(key)) {
      return ApiResponse.ok(
        ApiMemoryCache.get(key) as List<ContentItem>,
      );
    }

    final res = await ApiClient.get(path);

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
