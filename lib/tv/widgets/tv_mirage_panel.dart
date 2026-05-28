import 'package:flutter/material.dart';

class TVMiragePanel
    extends StatelessWidget {
  final int reflections;

  const TVMiragePanel({
    super.key,
    required this.reflections,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.flip,
            color: Colors.cyan,
            size: 76,
          ),
          const SizedBox(height: 22),
          Text(
            '$reflections Reflections',
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
