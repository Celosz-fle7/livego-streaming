import 'package:flutter/material.dart';

class TVGridPanel
    extends StatelessWidget {
  final int columns;

  const TVGridPanel({
    super.key,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.grid_view,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            '$columns Columns',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
