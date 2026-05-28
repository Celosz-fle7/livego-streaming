import 'package:flutter/material.dart';

class TVTokenStatusPanel extends StatelessWidget {
  final bool hasToken;

  const TVTokenStatusPanel({
    super.key,
    required this.hasToken,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            hasToken ? Icons.vpn_key : Icons.key_off,
            color: hasToken ? Colors.green : Colors.orange,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            hasToken ? 'TOKEN ACTIVE' : 'NO TOKEN',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
