import 'package:flutter/material.dart';

class TVProfileScreen
    extends StatelessWidget {
  const TVProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: const Center(
        child: Text(
          'Dracin Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
