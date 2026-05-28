import 'package:flutter/material.dart';

class TVUserStatsPanel
    extends StatelessWidget {
  final int minutes;
  final int completed;

  const TVUserStatsPanel({
    super.key,
    required this.minutes,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            '$minutes Minutes Watched',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$completed Series Completed',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
