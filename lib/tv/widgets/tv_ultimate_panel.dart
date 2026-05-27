import 'package:flutter/material.dart';

class TVUltimatePanel
    extends StatelessWidget {
  final int progress;

  const TVUltimatePanel({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.workspace_premium,
            color: Colors.amber,
            size: 64,
          ),
          const SizedBox(height: 20),
          Text(
            '$progress%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'ULTIMATE TV SYSTEM',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
