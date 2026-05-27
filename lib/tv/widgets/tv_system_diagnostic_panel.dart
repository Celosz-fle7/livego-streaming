import 'package:flutter/material.dart';

class TVSystemDiagnosticPanel
    extends StatelessWidget {

  final bool healthy;

  final String status;

  const TVSystemDiagnosticPanel({
    super.key,
    required this.healthy,
    required this.status,
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
            healthy
                ? Icons.verified
                : Icons.error,

            color:
                healthy
                    ? Colors.green
                    : Colors.red,

            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
