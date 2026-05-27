import 'package:flutter/material.dart';

import '../../api/services/auth_event_logger.dart';

class TVAuthLogPanel extends StatelessWidget {
  const TVAuthLogPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = AuthEventLogger.logs;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              logs[i],
              style: const TextStyle(
                color: Colors.green,
                fontFamily: 'monospace',
              ),
            ),
          );
        },
      ),
    );
  }
}
