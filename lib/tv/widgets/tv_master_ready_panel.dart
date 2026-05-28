import 'package:flutter/material.dart';

class TVMasterReadyPanel
    extends StatelessWidget {
  final int score;

  const TVMasterReadyPanel({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.verified_user,
            color: Colors.green,
            size: 60,
          ),
          const SizedBox(height: 18),
          Text(
            '$score%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 38,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'MASTER BUILD READY',
            style: TextStyle(
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
