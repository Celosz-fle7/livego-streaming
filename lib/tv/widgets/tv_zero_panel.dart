import 'package:flutter/material.dart';

class TVZeroPanel
    extends StatelessWidget {
  final int resets;

  const TVZeroPanel({
    super.key,
    required this.resets,
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
            Icons.restart_alt,
            color: Colors.red,
            size: 70,
          ),
          const SizedBox(height: 20),
          Text(
            '$resets Resets',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ],
      ),
    );
  }
}
