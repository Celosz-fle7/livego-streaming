import 'package:flutter/material.dart';

class TVFinalSafeLayer
    extends StatelessWidget {
  final Widget child;

  const TVFinalSafeLayer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: child,
    );
  }
}
