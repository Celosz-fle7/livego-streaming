import 'package:flutter/material.dart';

class TVSettingsScreen
    extends StatelessWidget {
  const TVSettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: ListView(
        padding:
            const EdgeInsets.all(32),
        children: const [
          Text(
            'Pengaturan TV',
            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
