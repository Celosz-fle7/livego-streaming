import 'package:flutter/material.dart';

class TVPrimePanel
    extends StatelessWidget {
  final int rank;

  const TVPrimePanel({
    super.key,
    required this.rank,
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
            Icons.military_tech,
            color: Colors.amber,
            size: 96,
          ),
          const SizedBox(height: 28),
          Text(
            'RANK $rank',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 54,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'PRIME SYSTEM',
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
