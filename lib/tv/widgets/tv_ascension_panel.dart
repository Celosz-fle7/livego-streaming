import 'package:flutter/material.dart';

class TVAscensionPanel
    extends StatelessWidget {
  final int wings;

  const TVAscensionPanel({
    super.key,
    required this.wings,
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
            Icons.flight,
            color: Colors.cyan,
            size: 84,
          ),
          const SizedBox(height: 24),
          Text(
            '$wings Wings',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'ASCENSION SYSTEM',
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
