import 'package:flutter/material.dart';

class TVDebugPanel
    extends StatelessWidget {
  final bool enabled;

  const TVDebugPanel({
    super.key,
    required this.enabled,
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
          Icon(
            enabled
                ? Icons.bug_report
                : Icons.shield,
            color: enabled
                ? Colors.orange
                : Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Debug Mode'
                : 'Release Mode',
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
