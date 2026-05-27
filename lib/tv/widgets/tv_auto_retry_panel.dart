import 'package:flutter/material.dart';

class TVAutoRetryPanel
    extends StatelessWidget {
  final bool enabled;
  final int retries;

  const TVAutoRetryPanel({
    super.key,
    required this.enabled,
    required this.retries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            enabled
                ? Icons.refresh
                : Icons.block,
            color:
                enabled ? Colors.green : Colors.red,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$retries Retries',
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
