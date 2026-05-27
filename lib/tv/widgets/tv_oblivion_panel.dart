import 'package:flutter/material.dart';

class TVOblivionPanel
    extends StatelessWidget {
  final int voids;

  const TVOblivionPanel({
    super.key,
    required this.voids,
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
          const Icon(
            Icons.delete_forever,
            color: Colors.red,
            size: 82,
          ),
          const SizedBox(height: 24),
          Text(
            '$voids Voids',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 46,
            ),
          ),
        ],
      ),
    );
  }
}
