import 'package:flutter/material.dart';

class TVPowerBadge
    extends StatelessWidget {
  final bool saving;

  const TVPowerBadge({
    super.key,
    required this.saving,
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
            saving ? Colors.orange : Colors.green,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        saving
            ? 'POWER SAVE'
            : 'FULL POWER',
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
