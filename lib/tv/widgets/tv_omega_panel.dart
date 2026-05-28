import 'package:flutter/material.dart';

class TVOmegaPanel
    extends StatelessWidget {
  final int rank;

  const TVOmegaPanel({
    super.key,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.diamond,
            color: Colors.amber,
            size: 72,
          ),
          const SizedBox(height: 22),
          Text(
            'RANK $rank',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'OMEGA SYSTEM',
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
