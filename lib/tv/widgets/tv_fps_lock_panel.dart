import 'package:flutter/material.dart';

class TVFPSLockPanel
    extends StatelessWidget {
  final int fps;

  const TVFPSLockPanel({
    super.key,
    required this.fps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.speed,
            color: Colors.cyan,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$fps FPS',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
