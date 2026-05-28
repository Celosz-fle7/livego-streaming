import 'package:flutter/material.dart';

class TVAutoRecoveryPanel
    extends StatelessWidget {
  final int recovered;

  const TVAutoRecoveryPanel({
    super.key,
    required this.recovered,
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
            Icons.restore,
            color: Colors.green,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$recovered Recoveries',
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
