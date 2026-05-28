import 'package:flutter/material.dart';

class TVOmniversePanel
    extends StatelessWidget {
  final int universes;

  const TVOmniversePanel({
    super.key,
    required this.universes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.blur_on,
            color: Colors.cyan,
            size: 92,
          ),
          const SizedBox(height: 26),
          Text(
            '$universes',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 56,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'OMNIVERSE SYSTEM',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
