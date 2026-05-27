import 'package:flutter/material.dart';

class TVPremiumBadge
    extends StatelessWidget {
  const TVPremiumBadge({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFD54F),
            Color(0xFFFFB300),
          ],
        ),
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: const Text(
        'PREMIUM',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
