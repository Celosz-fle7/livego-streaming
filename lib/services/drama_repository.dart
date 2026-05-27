import 'dart:convert';
import 'api_constants.dart';
import 'api_service.dart';

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

  static const goodshort = PlatformConfig(
    id: 'goodshort',
    name: 'GoodShort',
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

  static const allTrending = [
    freereels,
    dramawave,
    goodshort,
    reelshort,
    shortmax,
  ];

  static List<PlatformConfig> get tvPlatforms {
    return allTrending.where((e) => e.isTvFriendly).toList();
  }

  static PlatformConfig? findById(String id) {
    try {
      return allTrending.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  static const defaultMobileHomeIds = [
    'freereels',
    'dramawave',
    'goodshort',
  ];

  static const defaultTvHomeIds = [
    'freereels',
    'reelshort',
  ];
}

class DramaRepository {
  static const String _defaultLang = 'id';

  static Future<List<Map<String, dynamic>>> getTrending(
    String platform, {
    int page = 1,
    bool forceRefresh = false,
  }) async {
    final path =
        '${ApiConstants.dramas}?platform=$platform&lang=$_defaultLang&page=$page';

    final res = await ApiService.get(
      path,
      forceRefresh: forceRefresh,
    );

    return _extractList(res);
  }

  static Future<List<Map<String, dynamic>>> getByCategory(
    String platform,
    String cat, {
    int page = 1,
    bool forceRefresh = false,
  }) async {
    return getTrending(
      platform,
      page: page,
      forceRefresh: forceRefresh,
    );
  }

  static Future<List<Map<String, dynamic>>> search(
    String platform,
    String q, {
    int page = 1,
    bool forceRefresh = true,
  }) async {
    final encodedQ = Uri.encodeQueryComponent(q);

    final path =
        '${ApiConstants.search}?platform=$platform&q=$encodedQ&lang=$_defaultLang&page=$page';

    final res = await ApiService.get(
      path,
      forceRefresh: forceRefresh,
    );

    return _extractList(res);
  }

  static Future<Map<String, dynamic>?> getDetail(
    String id,
    String platform, {
    bool forceRefresh = false,
  }) async {
    final encodedId = Uri.encodeQueryComponent(id);

    final path =
        '${ApiConstants.detail}?id=$encodedId&platform=$platform&lang=$_defaultLang';

    final res = await ApiService.get(
      path,
      forceRefresh: forceRefresh,
    );

    if (res == null) return null;

    final data = res['data'];

    if (data is Map<String, dynamic>) return data;

    return res;
  }

  static Future<Map<String, dynamic>?> getVideo(
    String id,
    String platform, {
    int episode = 1,
    bool forceRefresh = true,
  }) async {
    final encodedId = Uri.encodeQueryComponent(id);

    final path =
        '${ApiConstants.video}?id=$encodedId&platform=$platform&chapter=$episode&lang=$_defaultLang';

    final res = await ApiService.get(
      path,
      forceRefresh: forceRefresh,
    );

    if (res == null) return null;

    final data = res['data'];

    if (data is Map<String, dynamic>) return data;

    return res;
  }

  static Future<List<Map<String, dynamic>>> getCategories({
    bool forceRefresh = false,
  }) async {
    final res = await ApiService.get(
      ApiConstants.categories,
      forceRefresh: forceRefresh,
    );

    return _extractList(res);
  }

  static List<Map<String, dynamic>> _extractList(Map<String, dynamic>? res) {
    if (res == null) return [];

    final data = res['data'];
    if (data is List) {
      return data
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }

    final dramas = res['dramas'];
    if (dramas is List) {
      return dramas
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }

    return [];
  }

  static String prettyJson(Object? value) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(value);
  }
}
