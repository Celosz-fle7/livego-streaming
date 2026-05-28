import 'package:flutter/material.dart';

class TVApocalypsePanel
    extends StatelessWidget {
  final int waves;

  const TVApocalypsePanel({
    super.key,
    required this.waves,
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
            Icons.warning_amber,
            color: Colors.red,
            size: 80,
          ),
          const SizedBox(height: 24),
          Text(
            '$waves Waves',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 44,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'APOCALYPSE MODE',
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
