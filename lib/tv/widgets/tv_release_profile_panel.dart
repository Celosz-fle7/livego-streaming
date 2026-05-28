import 'package:flutter/material.dart';

class TVReleaseProfilePanel extends StatelessWidget {
  final String profile;
  final VoidCallback onLow;
  final VoidCallback onBalanced;
  final VoidCallback onFull;

  const TVReleaseProfilePanel({
    super.key,
    required this.profile,
    required this.onLow,
    required this.onBalanced,
    required this.onFull,
  });

  Widget _btn(String text, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
            'RELEASE $profile',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 16),
          _btn('Low TV', onLow),
          _btn('Balanced TV', onBalanced),
          _btn('Full TV', onFull),
        ],
      ),
    );
  }
}
