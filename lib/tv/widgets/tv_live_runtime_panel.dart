import 'package:flutter/material.dart';

class TVLiveRuntimePanel
    extends StatelessWidget {

  final bool online;

  final int heartbeat;

  const TVLiveRuntimePanel({
    super.key,
    required this.online,
    required this.heartbeat,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 420,
      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          Icon(
            online
                ? Icons.cloud_done
                : Icons.cloud_off,

            color:
                online
                    ? Colors.green
                    : Colors.red,

            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$heartbeat',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'LIVE HEARTBEAT',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
