import 'package:flutter/material.dart';

class TVCosmicPanel
    extends StatelessWidget {
  final int stars;

  const TVCosmicPanel({
    super.key,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.star_outline,
            color: Colors.orange,
            size: 80,
          ),
          const SizedBox(height: 24),
          Text(
            '$stars',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'COSMIC SYSTEM',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
