import 'package:flutter/material.dart';

class TVPlayerEpisodePanel
    extends StatelessWidget {
  final int current;
  final int total;

  const TVPlayerEpisodePanel({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Text(
        'Episode $current / $total',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
