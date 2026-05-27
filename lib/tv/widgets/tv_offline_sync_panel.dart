import 'package:flutter/material.dart';

class TVOfflineSyncPanel extends StatelessWidget {
  final bool syncing;
  final int synced;
  final int failed;
  final VoidCallback onSync;

  const TVOfflineSyncPanel({
    super.key,
    required this.syncing,
    required this.synced,
    required this.failed,
    required this.onSync,
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
            syncing ? Icons.sync : Icons.cloud_sync,
            color: syncing ? Colors.orange : Colors.cyan,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            '$synced synced',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$failed failed',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: syncing ? null : onSync,
            child: const Text('Sync Now'),
          ),
        ],
      ),
    );
  }
}
