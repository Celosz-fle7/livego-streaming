import 'package:flutter/material.dart';

import '../../api/services/api_request_logger.dart';

class TVApiLogViewer extends StatelessWidget {
  const TVApiLogViewer({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = ApiRequestLogger.logs;

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
                color: Colors.cyan,
                fontFamily: 'monospace',
              ),
            ),
          );
        },
      ),
    );
  }
}
