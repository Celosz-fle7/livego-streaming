import 'package:flutter/material.dart';

class TVTranscendPanel
    extends StatelessWidget {
  final int realm;

  const TVTranscendPanel({
    super.key,
    required this.realm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.trending_up,
            color: Colors.green,
            size: 74,
          ),
          const SizedBox(height: 24),
          Text(
            'Realm $realm',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 44,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'TRANSCENDENCE',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
