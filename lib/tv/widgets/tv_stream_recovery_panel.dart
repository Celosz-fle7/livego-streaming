import 'package:flutter/material.dart';

class TVStreamRecoveryPanel
    extends StatelessWidget {
  final int retries;

  const TVStreamRecoveryPanel({
    super.key,
    required this.retries,
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
            Icons.restore,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 18),
          Text(
            '$retries Recoveries',
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
