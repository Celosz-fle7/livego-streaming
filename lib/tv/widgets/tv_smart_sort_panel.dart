import 'package:flutter/material.dart';

class TVSmartSortPanel
    extends StatelessWidget {
  final String mode;

  const TVSmartSortPanel({
    super.key,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
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
            Icons.sort,
            color: Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            mode,
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
