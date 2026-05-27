import 'package:flutter/material.dart';

import '../system/tv_feature_grid_v2.dart';

class TVSystemScreen
    extends StatelessWidget {

  const TVSystemScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor:
          Colors.black,

      body:
          TVFeatureGridV2(),
    );
  }
}
