import '../core/dracin/dracin_repository.dart';

class CategoryConfig {
  final String id;
  final String name;

  const CategoryConfig({
    required this.id,
    required this.name,
  });
}

class PlatformConfig {
  final String id;
  final String name;
  final bool isTvFriendly;
  final bool hasSearch;
  final List<CategoryConfig> categories;

  const PlatformConfig({
    required this.id,
    required this.name,
    this.isTvFriendly = false,
    this.hasSearch = true,
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

  static const defaults = [
    home,
    trending,
    populer,
    romance,
    action,
    dubbing,
  ];
}

class Platforms {
  static const freereels = PlatformConfig(
    id: 'freereels',
    name: 'FreeReels',
    isTvFriendly: true,
    categories: AppCategories.defaults,
  );

  static const dramawave = PlatformConfig(
    id: 'dramawave',
    name: 'DramaWave',
    isTvFriendly: true,
    categories: AppCategories.defaults,
  );

  static const reelshort = PlatformConfig(
    id: 'reelshort',
    name: 'ReelShort',
    isTvFriendly: true,
    categories: AppCategories.defaults,
  );

  static const shortmax = PlatformConfig(
    id: 'shortmax',
    name: 'ShortMax',
    isTvFriendly: true,
    categories: AppCategories.defaults,
  );

  static const goodshort = PlatformConfig(
    id: 'goodshort',
    name: 'GoodShort',
    categories: AppCategories.defaults,
  );

  static const allTrending = [
    freereels,
    dramawave,
    reelshort,
    shortmax,
    goodshort,
  ];

  static const defaultMobileHomeIds = [
    'freereels',
    'dramawave',
    'goodshort',
  ];

  static const defaultTvHomeIds = [
    'freereels',
    'reelshort',
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
}

class DramaRepository {
  static Future<List<PlatformConfig>> getCategories() async {
    return Platforms.allTrending;
  }

  static Future<List<dynamic>> getTrending(
    String platform, {
    bool forceRefresh = false,
  }) async {
    return DracinRepository.getTrending(platform);
  }

  static Future<List<dynamic>> getByCategory(
    String platform,
    String category, {
    bool forceRefresh = false,
  }) async {
    return DracinRepository.getTrending(platform);
  }

  static Future<List<dynamic>> search(
    String platform,
    String query, {
    bool forceRefresh = false,
  }) async {
    return DracinRepository.search(platform, query);
  }

  static Future<Map<String, dynamic>?> getDetail(
    String id,
    String platform, {
    bool forceRefresh = false,
  }) async {
    return DracinRepository.getDetail(id, platform);
  }

  static Future<Map<String, dynamic>?> getVideo(
    String id,
    String platform, {
    int episode = 1,
    String? quality,
    bool forceRefresh = false,
  }) async {
    return DracinRepository.getVideo(
      id: id,
      platform: platform,
      episode: episode,
    );
  }
}
