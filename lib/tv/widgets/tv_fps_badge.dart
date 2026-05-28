import 'package:flutter/material.dart';

class TVFPSBadge
    extends StatelessWidget {
  final int fps;

  const TVFPSBadge({
    super.key,
    required this.fps,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;

    if (fps < 55) {
      color = Colors.orange;
    }

    if (fps < 40) {
      color = Colors.red;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        '$fps FPS',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
