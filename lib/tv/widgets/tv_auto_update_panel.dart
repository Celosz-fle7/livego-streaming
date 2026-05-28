import 'package:flutter/material.dart';

class TVAutoUpdatePanel
    extends StatelessWidget {
  final bool enabled;
  final bool wifiOnly;

  const TVAutoUpdatePanel({
    super.key,
    required this.enabled,
    required this.wifiOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            enabled
                ? Icons.system_update
                : Icons.system_update_alt,
            color: enabled
                ? Colors.green
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Auto Update ON'
                : 'Auto Update OFF',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            wifiOnly
                ? 'WiFi Only'
                : 'All Networks',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
