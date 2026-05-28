import 'package:flutter/material.dart';

class TVAIStatusPanel
    extends StatelessWidget {

  final bool active;
  final int scans;
  final int decisions;

  const TVAIStatusPanel({
    super.key,
    required this.active,
    required this.scans,
    required this.decisions,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 420,
      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          Icon(
            active
                ? Icons.psychology
                : Icons.psychology_alt,

            color:
                active
                    ? Colors.cyan
                    : Colors.red,

            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$scans',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            '$decisions Decisions',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
