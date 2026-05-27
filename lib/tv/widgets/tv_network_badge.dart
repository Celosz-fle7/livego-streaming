import 'package:flutter/material.dart';

class TVNetworkBadge
    extends StatelessWidget {
  final String text;

  const TVNetworkBadge({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Colors.green;

    if (text == 'MEDIUM') {
      color = Colors.orange;
    }

    if (text == 'LOW') {
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
        text,
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
