import 'package:flutter/material.dart';

class TVParentalPanel
    extends StatelessWidget {
  final bool enabled;

  const TVParentalPanel({
    super.key,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            enabled
                ? Icons.lock
                : Icons.lock_open,
            color: enabled
                ? Colors.red
                : Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Parental Lock'
                : 'Unlocked',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
