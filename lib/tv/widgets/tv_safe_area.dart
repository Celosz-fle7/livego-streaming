import 'package:flutter/material.dart';

class TVSafeArea extends StatelessWidget {
  final Widget child;

  const TVSafeArea({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: child,
    );
  }
}
