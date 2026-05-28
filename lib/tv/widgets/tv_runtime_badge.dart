import 'package:flutter/material.dart';

class TVRuntimeBadge
    extends StatelessWidget {
  final int uptime;

  const TVRuntimeBadge({
    super.key,
    required this.uptime,
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
        color: Colors.teal,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        '${uptime}s',
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
