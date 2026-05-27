import 'package:flutter/material.dart';

class TVAbsolutePanel
    extends StatelessWidget {
  final int supremacy;

  const TVAbsolutePanel({
    super.key,
    required this.supremacy,
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
            Icons.workspace_premium,
            color: Colors.amber,
            size: 96,
          ),
          const SizedBox(height: 28),
          Text(
            '$supremacy',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 58,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'ABSOLUTE SYSTEM',
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
