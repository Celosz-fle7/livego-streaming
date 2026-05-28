import 'package:flutter/material.dart';

class TVPlayerButton extends StatelessWidget {
  final IconData icon;
  final bool focused;
  final VoidCallback onTap;
  final String? label;

  const TVPlayerButton({
    super.key,
    required this.icon,
    required this.focused,
    required this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: focused ? 1.12 : 1.0,
        duration:
            const Duration(milliseconds: 120),
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 120),
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: focused
                ? const Color(0xFF04D2FF)
                : Colors.white10,
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: focused
                    ? Colors.black
                    : Colors.white,
              ),
              if (label != null) ...[
                const SizedBox(width: 8),
                Text(
                  label!,
                  style: TextStyle(
                    color: focused
                        ? Colors.black
                        : Colors.white,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
