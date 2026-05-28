import 'package:flutter/material.dart';

class TVNavigationPolicyPanel extends StatelessWidget {
  final int focusMs;
  final int repeatMs;
  final bool glow;

  const TVNavigationPolicyPanel({
    super.key,
    required this.focusMs,
    required this.repeatMs,
    required this.glow,
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
          const Icon(Icons.settings_remote, color: Colors.cyan, size: 72),
          const SizedBox(height: 20),
          Text(
            '${focusMs}ms Focus',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '${repeatMs}ms repeat • Glow ${glow ? "ON" : "OFF"}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
