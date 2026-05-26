// lib/utils/mapping.dart
// OPTIMIZED VERSION
// Sinkron dengan drama_repository.dart — jangan edit manual, gunakan Platforms class

import '../services/drama_repository.dart';

class AppMapping {
  // 🔥 Caching untuk menghindari rebuild berulang
  static List<Map<String, String>>? _cachedPlatforms;
  static List<Map<String, String>>? _cachedTvPlatforms;
  static List<Map<String, String>>? _cachedSearchablePlatforms;

  // Platform list yang sinkron langsung dari Platforms config
  static List<Map<String, String>> get platforms {
    _cachedPlatforms ??= Platforms.allTrending.map((p) => {
          'id': p.id,
          'name': p.name,
        }).toList();
    return _cachedPlatforms!;
  }

  // Hanya platform TV-friendly
  static List<Map<String, String>> get tvPlatforms {
    _cachedTvPlatforms ??= Platforms.tvPlatforms.map((p) => {
          'id': p.id,
          'name': p.name,
        }).toList();
    return _cachedTvPlatforms!;
  }

  // Hanya platform yang support search
  static List<Map<String, String>> get searchablePlatforms {
    _cachedSearchablePlatforms ??= Platforms.allTrending
        .where((p) => p.hasSearch)
        .map((p) => {'id': p.id, 'name': p.name})
        .toList();
    return _cachedSearchablePlatforms!;
  }

  // 🔥 Optional: Refresh cache jika perlu (misal setelah update data)
  static void refreshCache() {
    _cachedPlatforms = null;
    _cachedTvPlatforms = null;
    _cachedSearchablePlatforms = null;
  }
}
