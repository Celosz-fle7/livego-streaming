import 'package:flutter/material.dart';

class TVFinalGoldPanel
    extends StatelessWidget {
  final int score;

  const TVFinalGoldPanel({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 56,
          ),
          const SizedBox(height: 18),
          Text(
            '$score%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 36,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'GOLD BUILD READY',
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
