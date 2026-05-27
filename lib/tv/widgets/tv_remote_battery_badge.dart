import 'package:flutter/material.dart';

class TVRemoteBatteryBadge
    extends StatelessWidget {
  final int battery;

  const TVRemoteBatteryBadge({
    super.key,
    required this.battery,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;

    if (battery <= 40) {
      color = Colors.orange;
    }

    if (battery <= 20) {
      color = Colors.red;
    }

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        '$battery%',
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
