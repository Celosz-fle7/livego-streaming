import 'package:flutter/material.dart';

class TVCorePanel
    extends StatelessWidget {
  final bool initialized;

  const TVCorePanel({
    super.key,
    required this.initialized,
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
        mainAxisSize:
            MainAxisSize.min,
        children: [
          Icon(
            initialized
                ? Icons.memory
                : Icons.warning,
            color: initialized
                ? Colors.green
                : Colors.orange,
            size: 40,
          ),
          const SizedBox(height: 16),
          Text(
            initialized
                ? 'Core Ready'
                : 'Core Booting',
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
