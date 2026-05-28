import 'package:flutter/material.dart';

class TVCloudPanel
    extends StatelessWidget {
  final bool connected;
  final String region;

  const TVCloudPanel({
    super.key,
    required this.connected,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
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
            connected
                ? Icons.cloud_done
                : Icons.cloud_off,
            color: connected
                ? Colors.green
                : Colors.red,
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            connected
                ? 'Connected'
                : 'Disconnected',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            region,
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
