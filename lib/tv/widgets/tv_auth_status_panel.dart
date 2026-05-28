import 'package:flutter/material.dart';

class TVAuthStatusPanel extends StatelessWidget {
  final bool loggedIn;
  final String name;

  const TVAuthStatusPanel({
    super.key,
    required this.loggedIn,
    required this.name,
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
            loggedIn ? Icons.verified_user : Icons.person_outline,
            color: loggedIn ? Colors.green : Colors.orange,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            loggedIn ? name : 'Guest',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            loggedIn ? 'AUTH ACTIVE' : 'AUTH INACTIVE',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
