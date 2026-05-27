import 'package:flutter/material.dart';

class TVMatrixPanel
    extends StatelessWidget {
  final bool active;
  final int layers;

  const TVMatrixPanel({
    super.key,
    required this.active,
    required this.layers,
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
          Icon(
            active
                ? Icons.grid_on
                : Icons.grid_off,
            color:
                active ? Colors.green : Colors.grey,
            size: 58,
          ),
          const SizedBox(height: 18),
          Text(
            '$layers Layers',
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
