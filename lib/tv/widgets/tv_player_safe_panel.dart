import 'package:flutter/material.dart';

class TVPlayerSafePanel
    extends StatelessWidget {
  final Widget child;

  const TVPlayerSafePanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          const EdgeInsets.all(22),
      child: child,
    );
  }
}
