import 'package:flutter/material.dart';

import '../terminal/tv_system_terminal_engine.dart';

class TVSystemTerminalPanel
    extends StatelessWidget {

  const TVSystemTerminalPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final logs =
        TVSystemTerminalEngine.output;

    return Container(
      padding:
          const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius:
            BorderRadius.circular(20),

        border: Border.all(
          color: Colors.green,
        ),
      ),

      child: ListView.builder(
        itemCount: logs.length,

        itemBuilder: (_, i) {

          return Padding(
            padding:
                const EdgeInsets.symmetric(
              vertical: 4,
            ),

            child: Text(
              logs[i],
              style: const TextStyle(
                color: Colors.green,
                fontFamily: 'monospace',
              ),
            ),
          );
        },
      ),
    );
  }
}
