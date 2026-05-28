import 'package:flutter/material.dart';

class TVSecureModePanel extends StatelessWidget {
  final bool enabled;
  final bool mockAllowed;

  const TVSecureModePanel({
    super.key,
    required this.enabled,
    required this.mockAllowed,
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
            enabled ? Icons.security : Icons.no_encryption,
            color: enabled ? Colors.green : Colors.red,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            enabled ? 'SECURE MODE' : 'UNSAFE MODE',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            mockAllowed ? 'Mock auth allowed' : 'Production auth only',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
