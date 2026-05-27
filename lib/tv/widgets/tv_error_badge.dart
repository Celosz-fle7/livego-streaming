import 'package:flutter/material.dart';

class TVErrorBadge
    extends StatelessWidget {
  final int count;

  const TVErrorBadge({
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
        color:
            count > 0 ? Colors.red : Colors.green,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        count > 0
            ? '$count ERROR'
            : 'STABLE',
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
