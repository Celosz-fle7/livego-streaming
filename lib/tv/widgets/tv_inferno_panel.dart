import 'package:flutter/material.dart';

class TVInfernoPanel
    extends StatelessWidget {
  final int flames;

  const TVInfernoPanel({
    super.key,
    required this.flames,
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
            Icons.local_fire_department,
            color: Colors.deepOrange,
            size: 96,
          ),
          const SizedBox(height: 28),
          Text(
            '$flames',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 54,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'INFERNO SYSTEM',
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
