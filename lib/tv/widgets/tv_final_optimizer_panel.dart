import 'package:flutter/material.dart';

class TVFinalOptimizerPanel
    extends StatelessWidget {
  final bool optimized;
  final int score;

  const TVFinalOptimizerPanel({
    super.key,
    required this.optimized,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            optimized
                ? Icons.verified
                : Icons.warning,
            color:
                optimized ? Colors.green : Colors.orange,
            size: 52,
          ),
          const SizedBox(height: 18),
          Text(
            '$score%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
