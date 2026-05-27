import 'package:flutter/material.dart';

class TVSupremePanel
    extends StatelessWidget {
  final int authority;

  const TVSupremePanel({
    super.key,
    required this.authority,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 460,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.workspace_premium,
            color: Colors.amber,
            size: 84,
          ),
          const SizedBox(height: 24),
          Text(
            '$authority',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 50,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'SUPREME SYSTEM',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
