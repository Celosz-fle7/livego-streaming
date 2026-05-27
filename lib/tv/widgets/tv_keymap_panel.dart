import 'package:flutter/material.dart';

class TVKeymapPanel
    extends StatelessWidget {
  final String keyName;
  final String action;

  const TVKeymapPanel({
    super.key,
    required this.keyName,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding:
          const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            keyName,
            style: const TextStyle(
              color: Colors.orange,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            action,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
