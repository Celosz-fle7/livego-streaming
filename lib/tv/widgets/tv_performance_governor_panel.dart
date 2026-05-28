import 'package:flutter/material.dart';

class TVPerformanceGovernorPanel
    extends StatelessWidget {

  final String mode;

  final VoidCallback onLow;

  final VoidCallback onBalanced;

  final VoidCallback onHigh;

  const TVPerformanceGovernorPanel({
    super.key,
    required this.mode,
    required this.onLow,
    required this.onBalanced,
    required this.onHigh,
  });

  Widget _btn(
    String text,
    VoidCallback onTap,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 8,
      ),

      child: ElevatedButton(
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }

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
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          const Icon(
            Icons.speed,
            color: Colors.green,
            size: 72,
          ),

          const SizedBox(height: 20),

          Text(
            mode,
            style: const TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 30,
            ),
          ),

          const SizedBox(height: 16),

          _btn(
            'LOW',
            onLow,
          ),

          _btn(
            'BALANCED',
            onBalanced,
          ),

          _btn(
            'HIGH',
            onHigh,
          ),
        ],
      ),
    );
  }
}
