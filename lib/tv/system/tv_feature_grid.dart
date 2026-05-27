import 'package:flutter/material.dart';

import 'tv_feature_registry.dart';
import 'tv_universal_panel.dart';

class TVFeatureGrid
    extends StatelessWidget {

  const TVFeatureGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final features =
        TVFeatureRegistry.features;

    return Scaffold(
      backgroundColor:
          Colors.black,

      body: GridView.builder(
        padding:
            const EdgeInsets.all(20),

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.2,
        ),

        itemCount: features.length,

        itemBuilder: (
          context,
          index,
        ) {

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
      ),
    );
  }
}
