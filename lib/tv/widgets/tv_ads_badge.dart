import 'package:flutter/material.dart';

class TVAdsBadge
    extends StatelessWidget {
  final bool enabled;

  const TVAdsBadge({
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
            enabled ? Colors.orange : Colors.green,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        enabled ? 'ADS ON' : 'ADS FREE',
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
