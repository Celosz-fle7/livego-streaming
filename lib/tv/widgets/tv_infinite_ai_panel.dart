import 'package:flutter/material.dart';

class TVInfiniteAIPanel
    extends StatelessWidget {
  final int intelligence;

  const TVInfiniteAIPanel({
    super.key,
    required this.intelligence,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.psychology,
            color: Colors.purple,
            size: 82,
          ),
          const SizedBox(height: 24),
          Text(
            '$intelligence',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'INFINITE AI',
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
