import 'package:flutter/material.dart';

class TVPosterScale extends StatelessWidget {
  final bool focused;
  final Widget child;

  const TVPosterScale({
    super.key,
    required this.focused,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: focused ? 1.08 : 1.0,
      duration:
          const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: child,
    );
  }
}
