import 'package:flutter/material.dart';

class TVAIVisionPanel
    extends StatelessWidget {
  final int detected;

  const TVAIVisionPanel({
    super.key,
    required this.detected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.visibility,
            color: Colors.green,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            '$detected Objects',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
