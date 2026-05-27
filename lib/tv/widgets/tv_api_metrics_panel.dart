import 'package:flutter/material.dart';

class TVApiMetricsPanel extends StatelessWidget {
  final int getRequests;
  final int postRequests;
  final int putRequests;

  const TVApiMetricsPanel({
    super.key,
    required this.getRequests,
    required this.postRequests,
    required this.putRequests,
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
          const Icon(Icons.http, color: Colors.green, size: 72),
          const SizedBox(height: 20),
          Text(
            'GET $getRequests',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'POST $postRequests • PUT $putRequests',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
