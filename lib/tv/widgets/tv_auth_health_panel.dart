import 'package:flutter/material.dart';

class TVAuthHealthPanel extends StatelessWidget {
  final bool healthy;
  final int unauthorized;
  final String status;

  const TVAuthHealthPanel({
    super.key,
    required this.healthy,
    required this.unauthorized,
    required this.status,
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
            healthy ? Icons.health_and_safety : Icons.gpp_bad,
            color: healthy ? Colors.green : Colors.red,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '401 hits $unauthorized',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
