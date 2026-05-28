import 'package:flutter/material.dart';

class TVSmartDiscoveryPanel
    extends StatelessWidget {
  final int total;

  const TVSmartDiscoveryPanel({
    super.key,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.travel_explore,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$total Discoveries',
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
