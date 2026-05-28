import 'package:flutter/material.dart';

class TVBootPanel
    extends StatelessWidget {
  final bool ready;

  const TVBootPanel({
    super.key,
    required this.ready,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding:
          const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            ready
                ? Icons.check_circle
                : Icons.sync,
            color: ready
                ? Colors.green
                : Colors.orange,
            size: 42,
          ),
          const SizedBox(height: 16),
          Text(
            ready
                ? 'System Ready'
                : 'Booting System',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
