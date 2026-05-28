import 'package:flutter/material.dart';

class TVAuthActionPanel extends StatelessWidget {
  final bool loggedIn;
  final VoidCallback onLogin;
  final VoidCallback onLogout;

  const TVAuthActionPanel({
    super.key,
    required this.loggedIn,
    required this.onLogin,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            loggedIn ? Icons.logout : Icons.login,
            color: loggedIn ? Colors.orange : Colors.green,
            size: 72,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: loggedIn ? onLogout : onLogin,
            child: Text(loggedIn ? 'Logout' : 'Mock Login'),
          ),
        ],
      ),
    );
  }
}
