import 'package:flutter/material.dart';

class TVSessionBadge
    extends StatelessWidget {
  final bool active;

  const TVSessionBadge({
    super.key,
    required this.active,
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
            active ? Colors.green : Colors.grey,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        active
            ? 'SESSION'
            : 'OFFLINE',
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
