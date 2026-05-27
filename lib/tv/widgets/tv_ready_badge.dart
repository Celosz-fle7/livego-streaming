import 'package:flutter/material.dart';

class TVReadyBadge
    extends StatelessWidget {
  final bool ready;

  const TVReadyBadge({
    super.key,
    required this.ready,
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
        color:
            ready ? Colors.green : Colors.orange,
        borderRadius:
            BorderRadius.circular(10),
      ),
      child: Text(
        ready
            ? 'PRODUCTION READY'
            : 'IN DEVELOPMENT',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
