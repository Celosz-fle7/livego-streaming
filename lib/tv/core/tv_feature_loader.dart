import '../managers/tv_feature_manager.dart';
import 'tv_engine_core.dart';

class TVFeatureLoader {

  static Future<void>
      load() async {

    final total =
        TVFeatureManager
            .enabledItems()
            .length;

    await Future.delayed(
      const Duration(
        milliseconds: 300,
      ),
    );

    TVEngineCore.initialize(
      total,
    );
  }
}
