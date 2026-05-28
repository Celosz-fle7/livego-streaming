import '../core/tv_memory_cache.dart';

class TVCacheCleaner {

  static int cleaned = 0;

  static void clean() {

    cleaned +=
        TVMemoryCache.cache.length;

    TVMemoryCache.clear();
  }
}
