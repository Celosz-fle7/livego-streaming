import 'package:flutter/material.dart';

class TVFirebasePanel
    extends StatelessWidget {
  final bool analytics;
  final bool crashlytics;

  const TVFirebasePanel({
    super.key,
    required this.analytics,
    required this.crashlytics,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                analytics
                    ? Icons.check_circle
                    : Icons.cancel,
                color: analytics
                    ? Colors.green
                    : Colors.red,
              ),
              const SizedBox(width: 12),
              const Text(
                'Firebase Analytics',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                crashlytics
                    ? Icons.check_circle
                    : Icons.cancel,
                color: crashlytics
                    ? Colors.green
                    : Colors.red,
              ),
              const SizedBox(width: 12),
              const Text(
                'Crashlytics',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
