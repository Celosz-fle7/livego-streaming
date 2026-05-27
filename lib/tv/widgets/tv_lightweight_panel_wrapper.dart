import 'package:flutter/material.dart';

class TVLightweightPanelWrapper
    extends StatelessWidget {

  final Widget child;

  const TVLightweightPanelWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {

    return RepaintBoundary(
      child: child,
    );
  }
}
