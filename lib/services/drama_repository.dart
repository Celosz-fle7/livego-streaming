import 'api_service.dart';

class DramaRepository {

  static Future<List> getTrending(String platform) async {
    final res = await ApiService.get('/api/v2/discover?platform=$platform&lang=id');
    return ApiService.safeList(res);
  }

  static Future<List> search(String platform, String query) async {
    final res = await ApiService.get('/api/v2/search?platform=$platform&q=${Uri.encodeComponent(query)}&lang=id');
    return ApiService.safeList(res);
  }

  static Future<Map<String, dynamic>?> getDetail(String id, String platform) async {
    return await ApiService.get('/api/v2/detail?id=$id&platform=$platform&lang=id');
  }

  static Future<Map<String, dynamic>?> getVideo(String id, String platform) async {
    final res = await ApiService.get('/api/v2/video?id=$id&platform=$platform&lang=id');
    final data = res?['data'] ?? res;
    final url = data?['video_url'];
    if (url == null) return null;
    return {'video_url': url};
  }
}
