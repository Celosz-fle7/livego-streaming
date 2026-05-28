import 'package:flutter/material.dart';

class TVCelestialAIPanel
    extends StatelessWidget {
  final int predictions;

  const TVCelestialAIPanel({
    super.key,
    required this.predictions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_graph,
            color: Colors.green,
            size: 76,
          ),
          const SizedBox(height: 22),
          Text(
            '$predictions Predictions',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),
        ],
      ),
    );
  }
}
