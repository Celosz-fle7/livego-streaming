import 'package:flutter/material.dart';

class TVQuantumPanel
    extends StatelessWidget {
  final int acceleration;

  const TVQuantumPanel({
    super.key,
    required this.acceleration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Colors.cyan,
            size: 60,
          ),
          const SizedBox(height: 18),
          Text(
            '$acceleration%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 38,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'QUANTUM BOOST',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
