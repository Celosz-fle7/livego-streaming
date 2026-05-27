import 'package:flutter/material.dart';

class TVKidsBadge
    extends StatelessWidget {
  final bool enabled;

  const TVKidsBadge({
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
            enabled ? Colors.pink : Colors.grey,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        enabled
            ? 'KIDS MODE'
            : 'STANDARD',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }
}
