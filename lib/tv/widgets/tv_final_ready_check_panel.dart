import 'package:flutter/material.dart';

class TVFinalReadyCheckPanel
    extends StatelessWidget {
  final bool ready;

  const TVFinalReadyCheckPanel({
    super.key,
    required this.ready,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            ready
                ? Icons.verified
                : Icons.warning,
            color:
                ready ? Colors.green : Colors.orange,
            size: 52,
          ),
          const SizedBox(height: 18),
          Text(
            ready
                ? 'SYSTEM READY'
                : 'CHECK REQUIRED',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }
}
