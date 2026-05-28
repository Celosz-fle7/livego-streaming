import 'package:flutter/material.dart';

class TVBlackholePanel
    extends StatelessWidget {
  final int absorbed;

  const TVBlackholePanel({
    super.key,
    required this.absorbed,
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
            Icons.blur_circular,
            color: Colors.deepPurple,
            size: 62,
          ),
          const SizedBox(height: 18),
          Text(
            '$absorbed Absorbed',
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
