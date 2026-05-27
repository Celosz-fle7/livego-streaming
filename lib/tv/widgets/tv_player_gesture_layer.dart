import 'package:flutter/material.dart';

class TVPlayerGestureLayer
    extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const TVPlayerGestureLayer({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior:
          HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
