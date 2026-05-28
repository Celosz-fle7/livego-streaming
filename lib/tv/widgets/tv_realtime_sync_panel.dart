import 'package:flutter/material.dart';

class TVRealtimeSyncPanel
    extends StatelessWidget {
  final bool active;
  final int synced;

  const TVRealtimeSyncPanel({
    super.key,
    required this.active,
    required this.synced,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            active
                ? Icons.sync
                : Icons.sync_disabled,
            color:
                active ? Colors.green : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$synced Synced',
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
