import 'package:flutter/material.dart';

class TVLeanbackBadge
    extends StatelessWidget {
  final bool enabled;

  const TVLeanbackBadge({
    super.key,
    required this.enabled,
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
            enabled ? Colors.green : Colors.red,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        enabled
            ? 'LEANBACK'
            : 'NO TV MODE',
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
