import 'package:flutter/material.dart';

class TVAutoCleanPanel
    extends StatelessWidget {
  final bool enabled;
  final int days;

  const TVAutoCleanPanel({
    super.key,
    required this.enabled,
    required this.days,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
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
                ? Icons.cleaning_services
                : Icons.block,
            color: enabled
                ? Colors.green
                : Colors.red,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Auto Clean ON'
                : 'Auto Clean OFF',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$days Days',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
