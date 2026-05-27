import 'package:flutter/material.dart';

class TVDailyLimitPanel
    extends StatelessWidget {
  final int watched;
  final int limit;

  const TVDailyLimitPanel({
    super.key,
    required this.watched,
    required this.limit,
  });

  @override
  Widget build(BuildContext context) {
    final progress = limit <= 0
        ? 0.0
        : (watched / limit)
            .clamp(0.0, 1.0);

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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Limit',
            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
          ),
          const SizedBox(height: 12),
          Text(
            '$watched / $limit Minutes',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
