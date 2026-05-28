import 'package:flutter/material.dart';

class TVSessionStatusPanel extends StatelessWidget {
  final bool loggedIn;
  final VoidCallback onLogout;

  const TVSessionStatusPanel({
    super.key,
    required this.loggedIn,
    required this.onLogout,
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
            loggedIn ? Icons.person : Icons.person_off,
            color: loggedIn ? Colors.green : Colors.orange,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            loggedIn ? 'SIGNED IN' : 'GUEST MODE',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onLogout,
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
