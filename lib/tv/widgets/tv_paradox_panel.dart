import 'package:flutter/material.dart';

class TVParadoxPanel
    extends StatelessWidget {
  final int loops;

  const TVParadoxPanel({
    super.key,
    required this.loops,
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
            Icons.sync_problem,
            color: Colors.red,
            size: 68,
          ),
          const SizedBox(height: 20),
          Text(
            '$loops Loops',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 38,
            ),
          ),
        ],
      ),
    );
  }
}
