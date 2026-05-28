import 'package:flutter/material.dart';

class TVCinemaLightPanel
    extends StatelessWidget {
  final int brightness;

  const TVCinemaLightPanel({
    super.key,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.light_mode,
            color: Colors.amber,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$brightness%',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ],
      ),
    );
  }
}
