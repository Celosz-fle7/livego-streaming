import 'package:flutter/material.dart';

class TVPlayerHeartbeatPanel
    extends StatelessWidget {
  final int heartbeat;

  const TVPlayerHeartbeatPanel({
    super.key,
    required this.heartbeat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$heartbeat Heartbeats',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
