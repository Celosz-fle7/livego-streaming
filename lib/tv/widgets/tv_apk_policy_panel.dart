import 'package:flutter/material.dart';

class TVAPKPolicyPanel extends StatelessWidget {
  final String target;
  final bool splitAbi;
  final bool shrink;

  const TVAPKPolicyPanel({
    super.key,
    required this.target,
    required this.splitAbi,
    required this.shrink,
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
          const Icon(Icons.android, color: Colors.green, size: 72),
          const SizedBox(height: 20),
          Text(
            target,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'ABI ${splitAbi ? "ON" : "OFF"} • Shrink ${shrink ? "ON" : "OFF"}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
