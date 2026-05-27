import 'package:flutter/material.dart';

class TVAmbientPanel
    extends StatelessWidget {
  final bool enabled;
  final int timeout;

  const TVAmbientPanel({
    super.key,
    required this.enabled,
    required this.timeout,
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
                ? Icons.tv
                : Icons.tv_off,
            color: enabled
                ? Colors.cyan
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Ambient Enabled'
                : 'Ambient Disabled',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$timeout min timeout',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
