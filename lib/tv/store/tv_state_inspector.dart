import 'tv_global_store.dart';

class TVStateInspector {
  static int totalKeys() {
    return TVGlobalStore.store.keys.length;
  }
}
