import 'package:flutter/material.dart';

class TVNetworkPanel
    extends StatelessWidget {
  final bool online;
  final bool metered;

  const TVNetworkPanel({
    super.key,
    required this.online,
    required this.metered,
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
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            online
                ? 'Online'
                : 'Offline',
            style: TextStyle(
              color: online
                  ? Colors.green
                  : Colors.red,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            metered
                ? 'Metered Network'
                : 'Unlimited Network',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
