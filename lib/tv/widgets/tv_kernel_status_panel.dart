import 'package:flutter/material.dart';

class TVKernelStatusPanel
    extends StatelessWidget {

  final bool running;

  final int processes;

  const TVKernelStatusPanel({
    super.key,
    required this.running,
    required this.processes,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 420,
      padding:
          const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          Icon(
            running
                ? Icons.memory
                : Icons.error,

            color:
                running
                    ? Colors.green
                    : Colors.red,

            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            '$processes',
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 42,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'KERNEL PROCESSES',
            style: TextStyle(
              color: Colors.white70,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
