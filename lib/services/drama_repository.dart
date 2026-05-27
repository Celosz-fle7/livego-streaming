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

  const PlatformConfig({
    required this.id,
    required this.name,
    this.isTvFriendly = false,
    this.hasSearch = true,
  });
}

class Platforms {
  static const freereels = PlatformConfig(
    id: 'freereels',
    name: 'FreeReels',
    isTvFriendly: true,
  );

  static const dramawave = PlatformConfig(
    id: 'dramawave',
    name: 'DramaWave',
    isTvFriendly: true,
  );

  static const reelshort = PlatformConfig(
    id: 'reelshort',
    name: 'ReelShort',
    isTvFriendly: true,
  );

  static const shortmax = PlatformConfig(
    id: 'shortmax',
    name: 'ShortMax',
    isTvFriendly: true,
  );

  static const goodshort = PlatformConfig(
    id: 'goodshort',
    name: 'GoodShort',
  );

  static const allTrending = [
    freereels,
    dramawave,
    reelshort,
    shortmax,
    goodshort,
  ];

  static List<PlatformConfig> get tvPlatforms =>
      allTrending.where((e) => e.isTvFriendly).toList();

  static PlatformConfig? findById(String id) {
    try {
      return allTrending.firstWhere(
        (e) => e.id == id,
      );
    } catch (_) {
      return null;
    }
  }
}

class DramaRepository {

  static Future<List<dynamic>> getTrending(
    String platform,
  ) async {
    return DracinRepository.getTrending(
      platform,
    );
  }

  static Future<List<dynamic>> search(
    String platform,
    String query,
  ) async {
    return DracinRepository.search(
      platform,
      query,
    );
  }

  static Future<Map<String, dynamic>?> getDetail(
    String id,
    String platform,
  ) async {
    return DracinRepository.getDetail(
      id,
      platform,
    );
  }

  static Future<Map<String, dynamic>?> getVideo(
    String id,
    String platform, {
    int episode = 1,
  }) async {
    return DracinRepository.getVideo(
      id: id,
      platform: platform,
      episode: episode,
    );
  }
}
