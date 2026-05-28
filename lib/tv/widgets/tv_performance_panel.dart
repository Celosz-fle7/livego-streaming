import 'package:flutter/material.dart';

class TVPerformancePanel
    extends StatelessWidget {
  final int fps;
  final double cpu;
  final double memory;

  const TVPerformancePanel({
    super.key,
    required this.fps,
    required this.cpu,
    required this.memory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            '$fps FPS',
            style: const TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'CPU ${cpu.toStringAsFixed(1)}%',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'RAM ${memory.toStringAsFixed(1)}%',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
