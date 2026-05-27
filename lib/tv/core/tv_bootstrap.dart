import 'tv_engine_core.dart';
import 'tv_feature_loader.dart';

class TVBootstrap {

  static Future<void>
      initialize() async {

    if (TVEngineCore.initialized) {
      return;
    }

    await TVFeatureLoader.load();
  }
}
