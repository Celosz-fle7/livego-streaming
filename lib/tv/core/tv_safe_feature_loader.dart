import '../managers/tv_feature_manager.dart';

class TVSafeFeatureLoader {

  static List load() {

    try {

      return TVFeatureManager
          .enabledItems();

    } catch (_) {

      return [];
    }
  }
}
