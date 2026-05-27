import 'package:flutter/material.dart';

class TVMemoryModePanel extends StatelessWidget {
  final String mode;
  final VoidCallback onLight;
  final VoidCallback onBalanced;
  final VoidCallback onFull;

  const TVMemoryModePanel({
    super.key,
    required this.mode,
    required this.onLight,
    required this.onBalanced,
    required this.onFull,
  });

  Widget _button(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }

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
          Text(
            mode,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 16),
          _button('Light Mode', onLight),
          _button('Balanced Mode', onBalanced),
          _button('Full Mode', onFull),
        ],
      ),
    );
  }
}
