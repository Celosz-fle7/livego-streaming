import 'package:flutter/material.dart';

class TVCelestialPanel
    extends StatelessWidget {
  final int energy;

  const TVCelestialPanel({
    super.key,
    required this.energy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.nights_stay,
            color: Colors.cyan,
            size: 72,
          ),
          const SizedBox(height: 22),
          Text(
            '$energy',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'CELESTIAL CORE',
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
