import 'package:flutter/material.dart';

class TVIsolatePanel
    extends StatelessWidget {
  final bool enabled;
  final int workers;

  const TVIsolatePanel({
    super.key,
    required this.enabled,
    required this.workers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const Text(
            'Isolate Engine',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            enabled
                ? 'Enabled'
                : 'Disabled',
            style: TextStyle(
              color: enabled
                  ? Colors.green
                  : Colors.red,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Workers: $workers',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
