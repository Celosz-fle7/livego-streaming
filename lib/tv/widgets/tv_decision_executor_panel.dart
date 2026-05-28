import 'package:flutter/material.dart';

class TVDecisionExecutorPanel extends StatelessWidget {
  final int executed;

  const TVDecisionExecutorPanel({
    super.key,
    required this.executed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.smart_toy,
            color: Colors.green,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            '$executed',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 42,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'AI EXECUTIONS',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
