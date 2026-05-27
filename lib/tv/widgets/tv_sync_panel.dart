import 'package:flutter/material.dart';

class TVSyncPanel
    extends StatelessWidget {
  final bool syncing;
  final int total;

  const TVSyncPanel({
    super.key,
    required this.syncing,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
                : Icons.done_all,
            color: syncing
                ? Colors.orange
                : Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            syncing
                ? 'Syncing'
                : '$total Synced',
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
