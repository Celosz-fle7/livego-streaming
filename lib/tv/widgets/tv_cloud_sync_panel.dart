import 'package:flutter/material.dart';

class TVCloudSyncPanel
    extends StatelessWidget {
  final bool syncing;

  const TVCloudSyncPanel({
    super.key,
    required this.syncing,
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
            syncing
                ? Icons.sync
                : Icons.cloud_done,
            color: syncing
                ? Colors.orange
                : Colors.green,
            size: 42,
          ),
          const SizedBox(height: 18),
          Text(
            syncing
                ? 'Syncing'
                : 'Cloud Synced',
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
