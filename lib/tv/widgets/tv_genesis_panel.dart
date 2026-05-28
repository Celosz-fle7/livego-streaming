import 'package:flutter/material.dart';

class TVGenesisPanel
    extends StatelessWidget {
  final int worlds;

  const TVGenesisPanel({
    super.key,
    required this.worlds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.language,
            color: Colors.green,
            size: 66,
          ),
          const SizedBox(height: 18),
          Text(
            '$worlds Worlds',
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
