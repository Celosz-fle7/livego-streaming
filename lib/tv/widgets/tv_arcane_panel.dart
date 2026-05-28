import 'package:flutter/material.dart';

class TVArcanePanel
    extends StatelessWidget {
  final int spells;

  const TVArcanePanel({
    super.key,
    required this.spells,
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
            Icons.auto_fix_high,
            color: Colors.purple,
            size: 72,
          ),
          const SizedBox(height: 20),
          Text(
            '$spells Spells',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),
        ],
      ),
    );
  }
}
