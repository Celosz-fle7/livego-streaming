import 'package:flutter/material.dart';

class TVNexusPanel
    extends StatelessWidget {
  final int nodes;

  const TVNexusPanel({
    super.key,
    required this.nodes,
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
            Icons.hub,
            color: Colors.cyan,
            size: 60,
          ),
          const SizedBox(height: 18),
          Text(
            '$nodes Nodes',
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
