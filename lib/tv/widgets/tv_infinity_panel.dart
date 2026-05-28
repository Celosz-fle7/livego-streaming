import 'package:flutter/material.dart';

class TVInfinityPanel
    extends StatelessWidget {
  final int power;

  const TVInfinityPanel({
    super.key,
    required this.power,
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
            Icons.all_inclusive,
            color: Colors.cyan,
            size: 70,
          ),
          const SizedBox(height: 20),
          Text(
            '$power',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'INFINITY CORE',
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
