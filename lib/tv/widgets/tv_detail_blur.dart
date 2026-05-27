import 'dart:ui';

import 'package:flutter/material.dart';

class TVDetailBlur extends StatelessWidget {
  const TVDetailBlur({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: Container(
          color: Colors.black54,
        ),
      ),
    );
  }
}
