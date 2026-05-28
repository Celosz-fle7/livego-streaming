import 'package:flutter/material.dart';

class TVEternalPanel
    extends StatelessWidget {
  final int cycles;

  const TVEternalPanel({
    super.key,
    required this.cycles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 440,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.timelapse,
            color: Colors.cyan,
            size: 76,
          ),
          const SizedBox(height: 22),
          Text(
            '$cycles',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 44,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'ETERNAL ENGINE',
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
