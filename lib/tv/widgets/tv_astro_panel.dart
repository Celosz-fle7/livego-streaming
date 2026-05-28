import 'package:flutter/material.dart';

class TVAstroPanel
    extends StatelessWidget {
  final int planets;

  const TVAstroPanel({
    super.key,
    required this.planets,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.travel_explore,
            color: Colors.orange,
            size: 60,
          ),
          const SizedBox(height: 18),
          Text(
            '$planets Planets',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ],
      ),
    );
  }
}
