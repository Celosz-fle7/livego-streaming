import 'package:flutter/material.dart';

class TVCosmosPanel
    extends StatelessWidget {
  final int galaxies;

  const TVCosmosPanel({
    super.key,
    required this.galaxies,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.public,
            color: Colors.cyan,
            size: 64,
          ),
          const SizedBox(height: 18),
          Text(
            '$galaxies Galaxies',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 36,
            ),
          ),
        ],
      ),
    );
  }
}
