import 'package:flutter/material.dart';

class TVOverlayFade extends StatelessWidget {
  final bool visible;
  final Widget child;

  const TVOverlayFade({
    super.key,
    required this.visible,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration:
            const Duration(milliseconds: 180),
        child: child,
      ),
    );
  }
}
