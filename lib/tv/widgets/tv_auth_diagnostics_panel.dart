import 'package:flutter/material.dart';

class TVAuthDiagnosticsPanel extends StatelessWidget {
  final int login;
  final int refresh;
  final int logout;
  final String status;

  const TVAuthDiagnosticsPanel({
    super.key,
    required this.login,
    required this.refresh,
    required this.logout,
    required this.status,
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
          const Icon(Icons.admin_panel_settings, color: Colors.cyan, size: 72),
          const SizedBox(height: 20),
          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Login $login • Refresh $refresh • Logout $logout',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
