import 'dracin_engine.dart';

class DracinRepository {

  // =========================
  // HOME / TRENDING
  // =========================

  static Future<List<dynamic>> getTrending(
    String platform,
  ) async {
    final res = await DracinEngine.discover(
      platform: platform,
    );

    return _extractList(res);
  }

  // =========================
  // SEARCH
  // =========================

  static Future<List<dynamic>> search(
    String platform,
    String query,
  ) async {
    final res = await DracinEngine.search(
      platform: platform,
      query: query,
    );

    return _extractList(res);
  }

  // =========================
  // DETAIL
  // =========================

  static Future<Map<String, dynamic>?> getDetail(
    String id,
    String platform,
  ) async {
    final res = await DracinEngine.detail(
      id: id,
      platform: platform,
    );

    if (res == null) return null;

    return res['data'] ??
        res;
  }

  // =========================
  // VIDEO
  // =========================

  static Future<Map<String, dynamic>?> getVideo({
    required String id,
    required String platform,
    int episode = 1,
  }) async {
    final res = await DracinEngine.video(
      id: id,
      platform: platform,
      episode: episode,
    );

    if (res == null) return null;

    return res['data'] ??
        res;
  }

  // =========================
  // EXTRACTORS
  // =========================

  static List<dynamic> _extractList(
    Map<String, dynamic>? res,
  ) {
    if (res == null) return [];

    if (res['data'] is List) {
      return res['data'];
    }

    if (res['dramas'] is List) {
      return res['dramas'];
    }

    return [];
  }
}
