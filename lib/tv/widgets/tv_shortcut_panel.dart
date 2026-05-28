import 'package:flutter/material.dart';

class TVShortcutPanel
    extends StatelessWidget {
  final String keyName;
  final String action;

  const TVShortcutPanel({
    super.key,
    required this.keyName,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            keyName,
            style: const TextStyle(
              color: Colors.cyan,
              fontWeight:
                  FontWeight.bold,
              fontSize: 28,
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
