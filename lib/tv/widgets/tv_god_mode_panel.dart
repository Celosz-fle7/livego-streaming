import 'package:flutter/material.dart';

class TVGodModePanel
    extends StatelessWidget {
  final bool enabled;
  final int level;

  const TVGodModePanel({
    super.key,
    required this.enabled,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.workspace_premium,
            color: Colors.amber,
            size: 68,
          ),
          const SizedBox(height: 20),
          Text(
            enabled
                ? 'LEVEL $level'
                : 'DISABLED',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 40,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'GOD MODE',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
