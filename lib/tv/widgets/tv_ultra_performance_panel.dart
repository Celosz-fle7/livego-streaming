import 'package:flutter/material.dart';

class TVUltraPerformancePanel
    extends StatelessWidget {
  final int score;

  const TVUltraPerformancePanel({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.rocket_launch,
            color: Colors.green,
            size: 62,
          ),
          const SizedBox(height: 20),
          Text(
            '$score%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'ULTRA PERFORMANCE',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
