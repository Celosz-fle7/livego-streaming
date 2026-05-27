import 'package:flutter/material.dart';

class TVScreenFitPanel
    extends StatelessWidget {
  final String mode;

  const TVScreenFitPanel({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.fit_screen,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            mode,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
