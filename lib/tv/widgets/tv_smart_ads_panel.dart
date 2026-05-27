import 'package:flutter/material.dart';

class TVSmartAdsPanel
    extends StatelessWidget {
  final int blocked;

  const TVSmartAdsPanel({
    super.key,
    required this.blocked,
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
            Icons.block,
            color: Colors.red,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$blocked Ads Blocked',
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
