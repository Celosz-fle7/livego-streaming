import 'package:flutter/material.dart';

class TVSmartBootPanel
    extends StatelessWidget {

  final int progress;

  final String status;

  const TVSmartBootPanel({
    super.key,
    required this.progress,
    required this.status,
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
            Icons.power_settings_new,
            color: Colors.cyan,
            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$progress%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            status,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
