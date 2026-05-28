import 'package:flutter/material.dart';

class TVPlaybackHistoryPanel
    extends StatelessWidget {
  final int total;

  const TVPlaybackHistoryPanel({
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
            Icons.history_toggle_off,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Sessions',
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
