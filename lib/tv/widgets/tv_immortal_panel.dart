import 'package:flutter/material.dart';

class TVImmortalPanel
    extends StatelessWidget {
  final int age;

  const TVImmortalPanel({
    super.key,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.self_improvement,
            color: Colors.green,
            size: 82,
          ),
          const SizedBox(height: 24),
          Text(
            '$age',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'IMMORTAL SYSTEM',
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
