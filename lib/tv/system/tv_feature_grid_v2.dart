import 'package:flutter/material.dart';

import '../managers/tv_feature_manager.dart';
import 'tv_universal_panel.dart';

class TVFeatureGridV2
    extends StatelessWidget {

  const TVFeatureGridV2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final features =
        TVFeatureManager
            .enabledItems();

    return GridView.builder(

      padding:
          const EdgeInsets.all(20),

      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.2,
      ),

      itemCount:
          features.length,

      itemBuilder:
          (context, index) {

        final feature =
            features[index];

        return TVUniversalPanel(
          title:
              feature.title,

          value:
              feature.value,

          icon:
              feature.icon,

          color:
              feature.color,
        );
      },
    );
  }
}
