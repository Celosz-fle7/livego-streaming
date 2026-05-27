import 'package:flutter/material.dart';

class TVApiDiagnosticsPanel extends StatelessWidget {
  final int total;
  final int failed;
  final int cacheHits;

  const TVApiDiagnosticsPanel({
    super.key,
    required this.total,
    required this.failed,
    required this.cacheHits,
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
          const Icon(Icons.analytics, color: Colors.cyan, size: 72),
          const SizedBox(height: 20),
          Text(
            '$total Requests',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$failed failed • $cacheHits cache hits',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
