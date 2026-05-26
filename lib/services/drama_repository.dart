import 'api_service.dart';

class CategoryConfig {
  final String id;
  final String name;
  const CategoryConfig({required this.id, required this.name});
}

class PlatformConfig {
  final String id;
  final String name;
  final bool isTvFriendly;
  final List<CategoryConfig> categories;

  const PlatformConfig({
    required this.id,
    required this.name,
    this.isTvFriendly = false,
    this.categories = const [],
  });
}

class AppCategories {
  static const home = CategoryConfig(id: 'home', name: 'HOME');
  static const trending = CategoryConfig(id: 'trending', name: 'TRENDING');
  static const populer = CategoryConfig(id: 'populer', name: 'POPULER');
  static const romance = CategoryConfig(id: 'romance', name: 'ROMANCE');
  static const action = CategoryConfig(id: 'action', name: 'ACTION');
  static const comedy = CategoryConfig(id: 'comedy', name: 'COMEDY');
  static const thriller = CategoryConfig(id: 'thriller', name: 'THRILLER');
  static const dubbing = CategoryConfig(id: 'dubbing', name: 'DUBBING');
}

class Platforms {
  static const freereels = PlatformConfig(id: 'freereels', name: 'FreeReels', isTvFriendly: true);
  static const dramawave = PlatformConfig(id: 'dramawave', name: 'DramaWave', isTvFriendly: true);
  static const goodshort = PlatformConfig(id: 'goodshort', name: 'GoodShort');
  static const reelshort = PlatformConfig(id: 'reelshort', name: 'ReelShort', isTvFriendly: true);
  static const shortmax = PlatformConfig(id: 'shortmax', name: 'ShortMax', isTvFriendly: true);

  static const allTrending = [
    freereels, dramawave, goodshort, reelshort, shortmax
  ];

  static List<PlatformConfig> get tvPlatforms =>
      allTrending.where((e) => e.isTvFriendly).toList();

  static PlatformConfig? findById(String id) {
    try {
      return allTrending.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  static const defaultMobileHomeIds = ['freereels','dramawave','goodshort'];
  static const defaultTvHomeIds = ['freereels','reelshort'];
}

class DramaRepository {

  static Future<List> getTrending(String platform) async {
    final res = await ApiService.get('/api/dramas?platform=$platform&lang=id');
    return _extract(res);
  }

  static Future<List> getByCategory(String platform, String cat) async {
    return getTrending(platform);
  }

  static Future<List> search(String platform, String q) async {
    final res = await ApiService.get('/api/search?platform=$platform&q=$q');
    return _extract(res);
  }

  static Future<Map<String,dynamic>?> getDetail(String id, String platform) async {
    return await ApiService.get('/api/detail?id=$id&platform=$platform');
  }

  static Future<Map<String,dynamic>?> getVideo(
    String id,
    String platform,
    {int episode = 1}
  ) async {
    return await ApiService.get('/api/video?id=$id&platform=$platform&chapter=$episode');
  }

  static List _extract(Map<String,dynamic>? res) {
    if (res == null) return [];
    if (res['data'] is List) return res['data'];
    if (res['dramas'] is List) return res['dramas'];
    return [];
  }
}
