import 'package:flutter/material.dart';

class TVHorizonPanel
    extends StatelessWidget {
  final int sectors;

  const TVHorizonPanel({
    super.key,
    required this.sectors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.explore,
            color: Colors.green,
            size: 76,
          ),
          const SizedBox(height: 22),
          Text(
            '$sectors Sectors',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 44,
            ),
          ),
        ],
      ),
    );
  }
}
