import 'package:flutter/material.dart';

class TVDRMPanel
    extends StatelessWidget {
  final bool enabled;
  final String provider;

  const TVDRMPanel({
    super.key,
    required this.enabled,
    required this.provider,
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
                ? Icons.lock
                : Icons.lock_open,
            color: enabled
                ? Colors.green
                : Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'DRM Enabled'
                : 'DRM Disabled',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            provider,
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
