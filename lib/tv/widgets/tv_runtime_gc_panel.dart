import 'package:flutter/material.dart';

class TVRuntimeGCPanel
    extends StatelessWidget {

  final int cleanupEvery;

  final bool aggressive;

  const TVRuntimeGCPanel({
    super.key,
    required this.cleanupEvery,
    required this.aggressive,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 420,

      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.black87,

        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          const Icon(
            Icons.cleaning_services,
            color: Colors.green,
            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$cleanupEvery sec',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 34,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            aggressive
                ? 'AGGRESSIVE'
                : 'BALANCED',

            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
