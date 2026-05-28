import 'package:flutter/material.dart';

class TVLiveBoostPanel
    extends StatelessWidget {
  final bool enabled;
  final int latency;

  const TVLiveBoostPanel({
    super.key,
    required this.enabled,
    required this.latency,
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
                ? Icons.flash_on
                : Icons.flash_off,
            color:
                enabled ? Colors.green : Colors.grey,
            size: 44,
          ),
          const SizedBox(height: 16),
          Text(
            '${latency}ms',
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
