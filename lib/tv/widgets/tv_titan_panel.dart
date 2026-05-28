import 'package:flutter/material.dart';

class TVTitanPanel
    extends StatelessWidget {
  final int level;

  const TVTitanPanel({
    super.key,
    required this.level,
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
            Icons.shield_moon,
            color: Colors.amber,
            size: 74,
          ),
          const SizedBox(height: 22),
          Text(
            'LEVEL $level',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 44,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'TITAN SYSTEM',
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
