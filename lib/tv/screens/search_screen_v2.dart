import 'package:flutter/material.dart';

class TVSearchScreenV2 extends StatelessWidget {
  const TVSearchScreenV2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF070B12),
      body: const Center(
        child: Text(
          'TV Search V2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
