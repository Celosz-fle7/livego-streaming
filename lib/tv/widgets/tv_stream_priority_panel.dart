import 'package:flutter/material.dart';

class TVStreamPriorityPanel
    extends StatelessWidget {
  final String priority;

  const TVStreamPriorityPanel({
    super.key,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.priority_high,
            color: Colors.red,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            priority,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
