import 'package:flutter/material.dart';

class TVPerformanceSummaryPanel extends StatelessWidget {
  final bool ready;
  final int fps;
  final int frameMs;
  final int cacheMb;

  const TVPerformanceSummaryPanel({
    super.key,
    required this.ready,
    required this.fps,
    required this.frameMs,
    required this.cacheMb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            ready ? Icons.verified : Icons.warning_amber,
            color: ready ? Colors.green : Colors.orange,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            '$fps FPS',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${frameMs}ms • Cache ${cacheMb}MB',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
