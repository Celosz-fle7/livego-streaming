import 'package:flutter/material.dart';

class TVApiStatusPanel extends StatelessWidget {
  final bool online;
  final int failures;
  final String error;

  const TVApiStatusPanel({
    super.key,
    required this.online,
    required this.failures,
    required this.error,
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
            online ? Icons.cloud_done : Icons.cloud_off,
            color: online ? Colors.green : Colors.red,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            online ? 'API ONLINE' : 'API OFFLINE',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Failures $failures ${error.isEmpty ? "" : "• $error"}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
