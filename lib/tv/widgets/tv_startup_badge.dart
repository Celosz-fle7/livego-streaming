import 'package:flutter/material.dart';

class TVStartupBadge
    extends StatelessWidget {
  final bool ready;

  const TVStartupBadge({
    super.key,
    required this.ready,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color:
            ready ? Colors.green : Colors.orange,
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: Text(
        ready ? 'READY' : 'BOOTING',
        style: const TextStyle(
          color: Colors.white,
          fontWeight:
              FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}
