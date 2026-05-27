import 'package:flutter/material.dart';

class TVAccountPanel
    extends StatelessWidget {
  final String email;
  final bool verified;

  const TVAccountPanel({
    super.key,
    required this.email,
    required this.verified,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(
            verified
                ? Icons.verified
                : Icons.warning,
            color: verified
                ? Colors.green
                : Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            email,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            verified
                ? 'Verified'
                : 'Unverified',
            style: const TextStyle(
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
