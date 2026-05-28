import 'package:flutter/material.dart';

class TVUpdatePanel
    extends StatelessWidget {
  final bool available;
  final String latest;

  const TVUpdatePanel({
    super.key,
    required this.available,
    required this.latest,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            available
                ? Icons.system_update
                : Icons.check_circle,
            color: available
                ? Colors.orange
                : Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            available
                ? 'Update Available'
                : 'System Updated',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Latest: $latest',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
