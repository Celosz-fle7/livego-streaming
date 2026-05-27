import 'package:flutter/material.dart';

class TVThreadBadge
    extends StatelessWidget {
  final int count;

  const TVThreadBadge({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        '$count THREAD',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
