import 'package:flutter/material.dart';

class TVDivinePanel
    extends StatelessWidget {
  final int blessing;

  const TVDivinePanel({
    super.key,
    required this.blessing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 520,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_awesome,
            color: Colors.yellow,
            size: 96,
          ),
          const SizedBox(height: 28),
          Text(
            '$blessing',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 56,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'DIVINE SYSTEM',
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
