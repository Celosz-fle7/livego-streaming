import 'package:flutter/material.dart';

class TVDimensionPanel
    extends StatelessWidget {
  final int dimensions;

  const TVDimensionPanel({
    super.key,
    required this.dimensions,
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
            Icons.view_in_ar,
            color: Colors.orange,
            size: 64,
          ),
          const SizedBox(height: 18),
          Text(
            '$dimensions Dimensions',
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
