import 'package:flutter/material.dart';

class TVWatchlistPanel
    extends StatelessWidget {
  final int total;

  const TVWatchlistPanel({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
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
            Icons.bookmark,
            color: Colors.amber,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Watchlist',
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
