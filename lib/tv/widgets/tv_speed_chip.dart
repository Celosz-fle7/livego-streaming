import 'package:flutter/material.dart';

class TVSpeedChip
    extends StatelessWidget {
  final double speed;

  const TVSpeedChip({
    super.key,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        '${speed}x',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
