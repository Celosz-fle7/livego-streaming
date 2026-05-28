import 'package:flutter/material.dart';

class TVMonitoringPanel
    extends StatelessWidget {
  final int users;
  final int streams;

  const TVMonitoringPanel({
    super.key,
    required this.users,
    required this.streams,
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
          const Icon(
            Icons.monitor,
            color: Colors.cyan,
            size: 42,
          ),
          const SizedBox(height: 18),
          Text(
            '$users Users',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$streams Streams',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
