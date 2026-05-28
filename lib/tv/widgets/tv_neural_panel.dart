import 'package:flutter/material.dart';

class TVNeuralPanel
    extends StatelessWidget {
  final int neurons;

  const TVNeuralPanel({
    super.key,
    required this.neurons,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.memory,
            color: Colors.purple,
            size: 60,
          ),
          const SizedBox(height: 18),
          Text(
            '$neurons',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 34,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'NEURAL ENGINE',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
