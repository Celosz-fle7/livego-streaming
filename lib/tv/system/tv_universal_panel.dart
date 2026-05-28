import 'package:flutter/material.dart';

class TVUniversalPanel
    extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const TVUniversalPanel({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 76,
          ),
          const SizedBox(height: 22),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 44,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
