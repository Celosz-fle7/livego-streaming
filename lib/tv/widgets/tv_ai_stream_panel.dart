import 'package:flutter/material.dart';

class TVAIStreamPanel
    extends StatelessWidget {
  final int optimized;

  const TVAIStreamPanel({
    super.key,
    required this.optimized,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.auto_fix_high,
            color: Colors.green,
            size: 44,
          ),
          const SizedBox(height: 16),
          Text(
            '$optimized Optimized',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
