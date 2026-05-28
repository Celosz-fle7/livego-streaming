import 'package:flutter/material.dart';

class TVUltraAIPanel
    extends StatelessWidget {
  final int actions;

  const TVUltraAIPanel({
    super.key,
    required this.actions,
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
            Icons.psychology_alt,
            color: Colors.purple,
            size: 46,
          ),
          const SizedBox(height: 16),
          Text(
            '$actions Learned',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
