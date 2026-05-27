import 'package:flutter/material.dart';

class TVNotificationPanel
    extends StatelessWidget {
  final int total;

  const TVNotificationPanel({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
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
            Icons.notifications,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Notifications',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
