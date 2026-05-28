import '../core/tv_memory_cache.dart';

class TVCacheStats {

  static int totalKeys() {

    return TVMemoryCache
        .cache
        .keys
        .length;
  }

  static bool has(
    String key,
  ) {

    return TVMemoryCache
        .cache
        .containsKey(key);
  }
}
