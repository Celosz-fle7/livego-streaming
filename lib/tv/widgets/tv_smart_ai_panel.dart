import 'package:flutter/material.dart';

class TVSmartAIPanel
    extends StatelessWidget {
  final int recommendations;

  const TVSmartAIPanel({
    super.key,
    required this.recommendations,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.psychology,
            color: Colors.purple,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$recommendations AI Picks',
            style: const TextStyle(
              color: Colors.white,
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
