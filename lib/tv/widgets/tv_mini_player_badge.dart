import 'package:flutter/material.dart';

class TVMiniPlayerBadge
    extends StatelessWidget {
  final bool enabled;

  const TVMiniPlayerBadge({
    super.key,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color:
            enabled ? Colors.green : Colors.grey,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        enabled
            ? 'MINI PLAYER'
            : 'FULL PLAYER',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
