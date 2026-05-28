import 'package:flutter/material.dart';

class TVLiveStatusPanel
    extends StatelessWidget {
  final bool live;
  final int viewers;

  const TVLiveStatusPanel({
    super.key,
    required this.live,
    required this.viewers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            live
                ? Icons.sensors
                : Icons.sensors_off,
            color:
                live ? Colors.red : Colors.grey,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            live
                ? '$viewers Watching'
                : 'Offline',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
