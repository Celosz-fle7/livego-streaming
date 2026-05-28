import 'package:flutter/material.dart';

class TVDeviceProfileModePanel extends StatelessWidget {
  final String profile;
  final int ramGb;

  const TVDeviceProfileModePanel({
    super.key,
    required this.profile,
    required this.ramGb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.tv,
            color: Colors.cyan,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            profile,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$ramGb GB RAM',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
