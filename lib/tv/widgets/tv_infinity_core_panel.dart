import 'package:flutter/material.dart';

class TVInfinityCorePanel
    extends StatelessWidget {
  final int cores;

  const TVInfinityCorePanel({
    super.key,
    required this.cores,
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
            Icons.hub,
            color: Colors.purple,
            size: 82,
          ),
          const SizedBox(height: 24),
          Text(
            '$cores Cores',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 46,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'INFINITY CORE',
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
