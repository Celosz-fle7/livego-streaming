import 'package:flutter/material.dart';

class TVSeekPanel
    extends StatelessWidget {
  final int forward;
  final int backward;

  const TVSeekPanel({
    super.key,
    required this.forward,
    required this.backward,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            '+$forward sec',
            style: const TextStyle(
              color: Colors.green,
              fontWeight:
                  FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '-$backward sec',
            style: const TextStyle(
              color: Colors.orange,
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
