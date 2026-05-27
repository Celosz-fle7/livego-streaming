import 'package:flutter/material.dart';

class TVApiHealthPanel extends StatelessWidget {
  final bool healthy;
  final String status;
  final VoidCallback onCheck;

  const TVApiHealthPanel({
    super.key,
    required this.healthy,
    required this.status,
    required this.onCheck,
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
          Icon(
            healthy ? Icons.verified : Icons.dns,
            color: healthy ? Colors.green : Colors.orange,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onCheck,
            child: const Text('Check API'),
          ),
        ],
      ),
    );
  }
}
