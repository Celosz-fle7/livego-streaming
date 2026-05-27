import 'package:flutter/material.dart';

class TVOfflinePanel
    extends StatelessWidget {
  final int total;

  const TVOfflinePanel({
    super.key,
    required this.total,
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
          const Icon(
            Icons.offline_bolt,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Offline',
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
