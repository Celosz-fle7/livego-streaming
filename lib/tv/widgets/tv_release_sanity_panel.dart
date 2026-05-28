import 'package:flutter/material.dart';

class TVReleaseSanityPanel extends StatelessWidget {
  final bool ready;
  final int score;

  const TVReleaseSanityPanel({
    super.key,
    required this.ready,
    required this.score,
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
            '$score%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            ready ? 'RELEASE READY' : 'NEEDS OPTIMIZE',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
