import 'package:flutter/material.dart';

class TVVoidPanel
    extends StatelessWidget {
  final int consumed;

  const TVVoidPanel({
    super.key,
    required this.consumed,
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
            Icons.dark_mode,
            color: Colors.deepPurple,
            size: 64,
          ),
          const SizedBox(height: 18),
          Text(
            '$consumed Consumed',
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
