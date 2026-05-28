import 'package:flutter/material.dart';

class TVDetailSafe
    extends StatelessWidget {
  final Widget child;

  const TVDetailSafe({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ),
      child: child,
    );
  }
}
