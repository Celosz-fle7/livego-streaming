import 'package:flutter/material.dart';

class TVPlayerBoostPanel
    extends StatelessWidget {
  final bool enabled;

  const TVPlayerBoostPanel({
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
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            enabled
                ? Icons.rocket_launch
                : Icons.rocket,
            color: enabled
                ? Colors.green
                : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Boost Enabled'
                : 'Boost Disabled',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
