import 'package:flutter/material.dart';

class TVHeroActionButton
    extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;

  const TVHeroActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          color: primary
              ? const Color(0xFF04D2FF)
              : Colors.white12,
          borderRadius:
              BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: primary
                  ? Colors.black
                  : Colors.white,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                color: primary
                    ? Colors.black
                    : Colors.white,
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
