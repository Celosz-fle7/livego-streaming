import 'package:flutter/material.dart';

class TVSafeModePanel
    extends StatelessWidget {
  final bool enabled;

  const TVSafeModePanel({
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
                ? Icons.security
                : Icons.security_outlined,
            color: enabled
                ? Colors.red
                : Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Safe Mode'
                : 'Normal Mode',
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
