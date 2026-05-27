import 'package:flutter/material.dart';

class TVRepaint extends StatelessWidget {
  final Widget child;

  const TVRepaint({
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
