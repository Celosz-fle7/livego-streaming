// lib/services/drama_repository.dart
// FINAL - ALL BUGS FIXED

import 'api_service.dart';

class CategoryConfig {
  final String id;
  final String name;
  const CategoryConfig({required this.id, required this.name});
}

class PlatformConfig {
  final String id;
  final String name;
  final bool hasSearch;
  final bool hasDiscover;
  final bool hasVideo;
  final bool hasDetail;
  final bool isTvFriendly;
  final List<CategoryConfig> categories;

  const PlatformConfig({
    required this.id, required this.name,
    this.hasSearch = true, this.hasDiscover = true, this.hasVideo = true,
    this.hasDetail = true, this.isTvFriendly = false,
    this.categories = const [],
  });
}

class AppCategories {
  static const home = CategoryConfig(id: 'home', name: 'HOME');
  static const trending = CategoryConfig(id: 'trending', name: 'TRENDING');
  static const populer = CategoryConfig(id: 'populer', name: 'POPULER');
  static const dubbing = CategoryConfig(id: 'dubbing', name: 'DUBBING');
  static const romance = CategoryConfig(id: 'romance', name: 'ROMANCE');
  static const action = CategoryConfig(id: 'action', name: 'ACTION');
  static const comedy = CategoryConfig(id: 'comedy', name: 'COMEDY');
  static const thriller = CategoryConfig(id: 'thriller', name: 'THRILLER');
}

class Platforms {
  static const freereels = PlatformConfig(id: 'freereels', name: 'FreeReels', isTvFriendly: true,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.dubbing, AppCategories.romance]);
  static const dramawave = PlatformConfig(id: 'dramawave', name: 'DramaWave', isTvFriendly: true,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.dubbing, AppCategories.comedy]);
  static const goodshort = PlatformConfig(id: 'goodshort', name: 'GoodShort',
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.comedy]);
  static const reelshort = PlatformConfig(id: 'reelshort', name: 'ReelShort', isTvFriendly: true,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.romance, AppCategories.action]);
  static const shortmax = PlatformConfig(id: 'shortmax', name: 'ShortMax', isTvFriendly: true,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.action, AppCategories.thriller]);
  static const dramarush = PlatformConfig(id: 'dramarush', name: 'DramaRush', isTvFriendly: true,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.romance, AppCategories.comedy]);
  static const rapidtv = PlatformConfig(id: 'rapidtv', name: 'RapidTV', isTvFriendly: true,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.thriller]);
  static const netshort = PlatformConfig(id: 'netshort', name: 'NetShort',
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.action]);
  static const melolo = PlatformConfig(id: 'melolo', name: 'Melolo',
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.comedy]);
  static const meloshort = PlatformConfig(id: 'meloshort', name: 'MeloShort',
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.romance]);
  static const reelife = PlatformConfig(id: 'reelife', name: 'Reelife',
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.romance]);
  static const flickreels = PlatformConfig(id: 'flickreels', name: 'FlickReels',
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.romance]);
  static const dramabite = PlatformConfig(id: 'dramabite', name: 'DramaBite',
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.action]);
  static const stardusttv = PlatformConfig(id: 'stardusttv', name: 'StardustTV', hasSearch: false, isTvFriendly: true,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer, AppCategories.action]);
  static const dramanova = PlatformConfig(id: 'dramanova', name: 'DramaNova', hasSearch: false,
    categories: [AppCategories.home, AppCategories.trending, AppCategories.populer]);
  static const dramabox = PlatformConfig(id: 'dramabox', name: 'DramaBox', hasDiscover: false,
    categories: [AppCategories.home, AppCategories.populer, AppCategories.romance]);
  static const drachin = PlatformConfig(id: 'drachin', name: 'Drachin', hasDiscover: false, hasSearch: false,
    categories: [AppCategories.home, AppCategories.populer]);

  static const List<PlatformConfig> allTrending = [
    freereels, dramawave, goodshort, reelshort, shortmax, dramarush,
    rapidtv, netshort, melolo, meloshort, reelife, flickreels,
    dramabite, stardusttv, dramanova, dramabox, drachin,
  ];

  static const List<String> defaultMobileHomeIds = ['freereels', 'dramawave', 'goodshort', 'reelshort', 'shortmax', 'dramarush'];
  static const List<String> defaultTvHomeIds = ['freereels', 'reelshort', 'dramawave', 'shortmax', 'dramarush', 'rapidtv'];
  static List<PlatformConfig> get tvPlatforms => allTrending.where((p) => p.isTvFriendly).toList();
  static PlatformConfig? findById(String id) { try { return allTrending.firstWhere((p) => p.id == id); } catch (_) { return null; } }
}

class DramaRepository {

  static Future<List> getTrending(String platform, {int page = 1}) async {
    final config = Platforms.findById(platform);
    if (config == null || !config.hasDiscover) return []; // 🔥 FIX: cek hasDiscover
    final path = '/api/dramas?platform=$platform&lang=id';
    final res = await ApiService.get(path);
    return _extractList(res);
  }

  static Future<Map<String, List>> getTrendingAll({bool tvMode = false, int page = 1}) async {
    final platforms = tvMode ? Platforms.tvPlatforms : Platforms.allTrending.where((p) => p.hasDiscover).toList();
    final Map<String, List> result = {};
    await Future.wait(platforms.map((p) async {
      final data = await getTrending(p.id, page: page);
      if (data.isNotEmpty) result[p.id] = data;
    }));
    return result;
  }

  static Future<List> getPopular(String platform) async => getTrending(platform);
  static Future<List> getDubbing(String platform) async {
    final config = Platforms.findById(platform);
    if (config == null || !config.hasSearch) return [];
    final path = '/api/search?platform=$platform&q=sulih%20suara&lang=id';
    final res = await ApiService.get(path);
    return _extractList(res);
  }

  // 🔥 FIX: KATEGORI SEKARANG BERFUNGSI
  static Future<List> getByCategory(String platform, String categoryId, {int page = 1}) async {
    final config = Platforms.findById(platform);
    if (config == null) return [];

    switch (categoryId) {
      case 'dubbing': return getDubbing(platform);
      case 'romance': return _searchByGenre(platform, 'romance');
      case 'action': return _searchByGenre(platform, 'action');
      case 'comedy': return _searchByGenre(platform, 'comedy');
      case 'thriller': return _searchByGenre(platform, 'thriller');
      default: return getTrending(platform, page: page);
    }
  }

  static Future<List> _searchByGenre(String platform, String genre) async {
    final config = Platforms.findById(platform);
    // Platform tanpa search → fallback ke trending daripada error
    if (config == null || !config.hasSearch) return getTrending(platform);
    final path = '/api/search?platform=$platform&q=${Uri.encodeComponent(genre)}&lang=id';
    final res = await ApiService.get(path);
    final list = _extractList(res);
    // Jika search kosong, fallback ke trending
    if (list.isNotEmpty) return list;
    return await getTrending(platform);
  }

  // 🔥 FIX: ENDPOINT WORKER — handle response dengan/tanpa success wrapper
  static Future<Map<String, dynamic>?> getDetail(String id, String platform) async {
    final config = Platforms.findById(platform);
    if (config == null || !config.hasDetail) return null;
    final path = '/api/detail?id=$id&platform=$platform&lang=id';
    final res = await ApiService.get(path);
    if (res == null) return null;
    // Worker bisa return {success:true, data:{...}} atau langsung {...}
    if (res['success'] == true && res['data'] != null) return res['data'];
    if (res['id'] != null || res['title'] != null) return res;
    return null;
  }

  // 🔥 FIX: named param agar bisa dipanggil dengan quality: value
  static Future<Map<String, dynamic>?> getVideo(
    String id,
    String platform, {
    int episode = 1,
    String? quality,
  }) async {
    final config = Platforms.findById(platform);
    if (config == null || !config.hasVideo) return null;
    var path = '/api/video?id=$id&platform=$platform&chapter=$episode&lang=id';
    if (quality != null && quality != 'Auto') path += '&quality=$quality';
    final res = await ApiService.get(path, forceRefresh: true);
    if (res == null) return null;
    // Worker bisa return {success:true, data:{...}} atau field langsung di root
    final data = (res['success'] == true && res['data'] is Map)
        ? res['data'] as Map<String, dynamic>
        : res;
    final videoUrl = data['video_url']?.toString() ?? '';
    if (videoUrl.isEmpty) return null;
    return {
      'video_url': videoUrl,
      'subtitle_url': data['subtitle_url']?.toString() ?? '',
      'episode': data['episode'] ?? episode,
      'total_episodes': data['total_episodes'] ?? 1,
    };
  }

  static Future<List> search(String platform, String query) async {
    final config = Platforms.findById(platform);
    if (config == null || !config.hasSearch) return [];
    final path = '/api/search?platform=$platform&q=${Uri.encodeComponent(query)}&lang=id';
    final res = await ApiService.get(path, forceRefresh: true);
    return _extractList(res);
  }

  static Future<Map<String, List>> searchAll(String query) async {
    final platforms = Platforms.allTrending.where((p) => p.hasSearch).toList();
    final Map<String, List> result = {};
    await Future.wait(platforms.map((p) async {
      final data = await search(p.id, query);
      if (data.isNotEmpty) result[p.id] = data;
    }));
    return result;
  }

  static Future<List<Map<String, String>>> getCategories() async {
    final res = await ApiService.get('/api/categories');
    if (res != null && res['success'] == true) {
      final List data = res['data'] ?? [];
      return data.map((item) => {
        'id': item['name']?.toString() ?? '',
        'name': item['display_name']?.toString() ?? '',
        'logo': item['logo_url']?.toString() ?? '',
      }).toList();
    }
    return [];
  }

  static List _extractList(Map<String, dynamic>? res) {
    if (res == null) return [];
    // Format 1: {success: true, dramas: [...]}
    // Format 2: {success: true, data: [...]}
    // Format 3: {dramas: [...]} tanpa success
    // Format 4: [...] langsung (ditangani di caller)
    if (res['dramas'] is List) return res['dramas'];
    if (res['data'] is List) return res['data'];
    if (res['results'] is List) return res['results'];
    return [];
  }
}