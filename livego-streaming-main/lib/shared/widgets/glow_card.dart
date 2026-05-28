// lib/shared/widgets/glow_card.dart
// OPTIMIZED VERSION
// Container glow universal — dipakai banner, platform tabs, category tabs

import 'package:flutter/material.dart';

class GlowCard extends StatelessWidget {
  final Widget child;
  final bool isActive;
  final double radius;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const GlowCard({
    super.key,
    required this.child,
    this.isActive = false,
    this.radius = 14,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150), // 200 -> 150ms
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1520).withOpacity(0.95),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: isActive
                ? const Color(0xFF06B6D4).withOpacity(0.70)
                : Colors.white.withOpacity(0.07),
            width: 1.5,
          ),
          boxShadow: [
            if (isActive)
              BoxShadow(
                color: const Color(0xFF06B6D4).withOpacity(0.18),
                blurRadius: 18,
                spreadRadius: 1,
              ),
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 8,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

// Chip pill untuk platform/kategori
class PillChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isFocused;
  final VoidCallback onTap;

  const PillChip({
    super.key,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.isFocused = false,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100), // 150 -> 100ms
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: _getBackgroundColor(),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _getBorderColor(),
              width: isFocused ? 2 : 1,
            ),
            boxShadow: isFocused
                ? [
                    BoxShadow(
                      color: const Color(0xFF06B6D4).withOpacity(0.5),
                      blurRadius: 10,
                    )
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: _getTextColor(),
              fontWeight: isFocused || isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isFocused) return const Color(0xFF06B6D4);
    if (isSelected) return const Color(0xFF06B6D4).withOpacity(0.15);
    return Colors.white.withOpacity(0.05);
  }

  Color _getBorderColor() {
    if (isFocused) return Colors.white;
    if (isSelected) return const Color(0xFF06B6D4).withOpacity(0.8);
    return Colors.white12;
  }

  Color _getTextColor() {
    if (isFocused) return Colors.black;
    if (isSelected) return const Color(0xFF06B6D4);
    return Colors.white60;
  }
}
