import 'package:flutter/material.dart';

class TVBackgroundDimmer
    extends StatelessWidget {
  final bool active;

  const TVBackgroundDimmer({
    super.key,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedContainer(
        duration:
            const Duration(milliseconds: 180),
        color: active
            ? Colors.black.withOpacity(0.45)
            : Colors.transparent,
      ),
    );
  }
}
