import 'package:flutter/material.dart';

class TVFinalFormPanel
    extends StatelessWidget {
  final int evolution;

  const TVFinalFormPanel({
    super.key,
    required this.evolution,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 540,
      padding: const EdgeInsets.all(34),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(34),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.bolt,
            color: Colors.amber,
            size: 100,
          ),
          const SizedBox(height: 30),
          Text(
            '$evolution%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 60,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'FINAL FORM SYSTEM',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
