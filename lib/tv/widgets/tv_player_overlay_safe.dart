import 'package:flutter/material.dart';

class TVPlayerOverlaySafe
    extends StatelessWidget {
  final Widget child;

  const TVPlayerOverlaySafe({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: child,
    );
  }
}
